using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.IO;

namespace Launcher
{
    public partial class ConfigEditor : Form
    {
        List<ServerConfig> configurations;
        List<string> basic = new List<string>();

        public ConfigEditor()
        {
            InitializeComponent();
        }

        private void ConfigEditor_Load(object sender, EventArgs e)
        {
            configurations = new List<ServerConfig>();
            foreach (string f in Directory.GetFiles("Launcher\\Configs\\"))
            {
                string s = f.Replace("Launcher\\Configs\\", "");
                if (s.EndsWith(".conf"))
                {
                    configurations.Add(new ServerConfig(this, s));
                    listBox1.Items.Add(s.Replace(".conf", ""));
                }
            }

            listBox1.SelectedIndex = 0;
        }

        private string RemoveBreaks(string s)
        {
            return s.Replace("\r\n", "").Replace("\n", "").Replace("\r", "");
        }

        public List<ConfigSection> ParseConfig(string path)
        {
            List<ConfigSection> result = new List<ConfigSection>();
            using (StreamReader reader = new StreamReader("Launcher\\BasicConfig.ini"))
            {
                string buffer = "";
                while ((buffer = reader.ReadLine()) != null)
                {
                    basic.Add(buffer.Replace(" ", ""));
                }
            }

            using (StreamReader reader = new StreamReader(path))
            {
                List<string> sectionchunk = new List<string>();
                string buffer = "";
                bool chunkOpen = false; bool skip = false;
                while ((buffer = reader.ReadLine()) != null)
                {
                    int crosses = 0;
                    for (int x = 0; x < buffer.Length; x++)
                    {
                        if (buffer[x] == '#')
                            crosses++;
                        if (crosses == 5)
                        {
                            if (!chunkOpen)
                            {
                                chunkOpen = true;
                                skip = true;
                            }
                            else
                            {
                                ProcessChunk(sectionchunk, result);
                                sectionchunk.Clear();
                                chunkOpen = false;
                            }
                        }
                    }

                    if (chunkOpen && !skip)
                        sectionchunk.Add(buffer);
                    else if (skip)
                        skip = false;
                }
            }

            return result;
        }

        public void ReloadLists()
        {
            treeView1.Nodes.Clear();
            List<ConfigSection> sections = GetSelectedConfig().actual;

            foreach(ConfigSection s in sections)
            {
                TreeNode configSection = new TreeNode(s.name);
                ConfigSection section = new ConfigSection(configSection.Text);
                configSection.Tag = section;

                bool visible = false;
                foreach (Config c in s.configs)
                {
                    if ((!checkBox1.Checked && basic.Contains(c.name)) || checkBox1.Checked)
                    {
                        visible = true;
                        TreeNode valueNode = new TreeNode(c.name);
                        valueNode.Tag = c;
                        if (c.value != GetSelectedConfig().GetTemplate(c).value)
                            valueNode.NodeFont = new Font("Arial", 8, FontStyle.Underline);
                        else
                            valueNode.NodeFont = new Font("Arial", 8, FontStyle.Regular);
                        configSection.Nodes.Add(valueNode);
                    }
                }

                bool normal = true;
                foreach (TreeNode n in configSection.Nodes)
                {
                    if (((Config)n.Tag).value != GetSelectedConfig().GetTemplate((Config)n.Tag).value)
                    {
                        normal = false;
                        break;
                    }
                }

                if (!normal)
                    configSection.NodeFont = new Font("Arial", 8, FontStyle.Underline);
                else
                    configSection.NodeFont = new Font("Arial", 8, FontStyle.Regular);

                if (visible)
                    treeView1.Nodes.Add(configSection);
            }
        }

        public ServerConfig GetSelectedConfig()
        {
            foreach (ServerConfig s in configurations)
            {
                if(s.name.StartsWith(listBox1.SelectedItem.ToString()))
                    return s;
            }

            return null;
        }

        private void ProcessChunk(List<string> chunk, List<ConfigSection> sections)
        {
            if (chunk.Count > 1)
            {
                TreeNode configSection = new TreeNode(chunk[0].Replace("#", ""));
                ConfigSection section = new ConfigSection(configSection.Text);
                configSection.Tag = section;

                List<Config> config = new List<Config>();
                Section sectionType = Section.Name;
                string clearline = "";
                for (int x = 1; x < chunk.Count; x++)
                {
                    clearline = RemoveStartingSpaces(chunk[x].Replace("#", ""));
                    if (chunk[x].StartsWith("#"))
                    {
                        if (SwitchSection(clearline) != Section.None)
                            sectionType = SwitchSection(clearline);
                        clearline = RemoveBreaks(RemoveSectionInfo(clearline));
                        if (clearline.Length > 0 || sectionType == Section.Value)
                        {

                            switch (sectionType)
                            {
                                case Section.Value:
                                    foreach (Config c in config)
                                    {
                                        section.configs.Add(c);
                                        TreeNode valueNode = new TreeNode(c.name);
                                        valueNode.Tag = c;
                                        configSection.Nodes.Add(valueNode);
                                    }
                                    config.Clear();
                                    sectionType = Section.Name;
                                    break;
                                case Section.Name:
                                    config.Add(new Config(clearline));
                                    break;
                                case Section.Description:
                                    foreach (Config c in config)
                                        c.description += clearline;
                                    break;
                                case Section.Example:
                                    foreach (Config c in config)
                                        c.example += clearline;
                                    break;
                                case Section.Range:
                                    foreach (Config c in config)
                                        c.range += clearline;
                                    break;
                                case Section.Important:
                                    foreach (Config c in config)
                                        c.important += clearline;
                                    break;
                                case Section.Default:
                                    foreach (Config c in config)
                                        c.AddDefault(clearline);
                                    break;
                                case Section.None:
                                    break;

                            }
                        }
                    }
                    else
                    {
                        sectionType = Section.Value;
                        if (clearline.Length > 0)
                        {
                            foreach (Config c in config)
                            {
                                if (c.value == null)
                                {
                                    if (clearline.Split('=').Length > 1)
                                    {
                                        c.value = clearline.Split('=')[1];
                                        c.type = TryToGuessType(clearline);
                                        c.value = c.value.Trim('"', ' ');
                                    }
                                    else
                                        clearline = "";

                                    break;
                                }
                            }
                        }
                    }

                }

                sections.Add(section);
            }
        }

        private Section SwitchSection(string clearline)
        {
            if (clearline.StartsWith("Description:"))
                return Section.Description;
            if (clearline.StartsWith("Important:"))
                return Section.Important;
            if (clearline.StartsWith("Example:"))
                return Section.Example;
            if (clearline.StartsWith("Default:"))
                return Section.Default;
            if (clearline.StartsWith("Range:"))
                return Section.Range;

            return Section.None;
        }

        private string RemoveStartingSpaces(string line)
        {
            for (int x = 0; x < line.Length; x++)
            {
                if (line[x] != ' ')
                    return line.Remove(0, x);
            }

            return "";
        }

        private string RemoveSectionInfo(string clearline)
        {
            return RemoveStartingSpaces(clearline.Replace("Description:", "").Replace("Important:", "").Replace("Example:", "").Replace("Default:", "").Replace("Range:", ""));
        }

        private ValueType TryToGuessType(string clearline)
        {
            string[] split = clearline.Split('=');
            if (split.Length > 1)
            {
                foreach (Match match in Regex.Matches(split[1], "\"(.*)\""))
                {
                    return ValueType.String;
                }

                if (split[1].Contains("."))
                {
                    float result;
                    if (float.TryParse(split[1].Replace(".", ","), out result))
                    { return ValueType.Float; }
                }
                else
                {
                    int result;
                    if (int.TryParse(split[1].Replace(" ", ""), out result))
                    { return ValueType.Int; }
                }
            }


            return ValueType.Generic;
        }

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            textBox1.Text = "";
            textBox2.Text = "";
            flowLayoutPanel1.Controls.Clear();
            if (treeView1.SelectedNode.Nodes.Count == 0)
            {
                if (((Config)treeView1.SelectedNode.Tag) != null)
                {
                    foreach (FlowLayoutPanel f in ((Config)treeView1.SelectedNode.Tag).GetInfoGui())
                    {
                        flowLayoutPanel1.Controls.Add(f);
                        textBox1.Text = ((Config)treeView1.SelectedNode.Tag).value;
                        label6.Text = ((Config)treeView1.SelectedNode.Tag).type.ToString();
                        if (((Config)treeView1.SelectedNode.Tag).type == ValueType.String)
                        {
                            textBox1.Text = textBox1.Text.Trim('"', ' ');
                        }

                        textBox2.Text = GetSelectedConfig().GetTemplate((Config)treeView1.SelectedNode.Tag).value;
                    }

                    textBox1.ReadOnly = false;
                    button3.Enabled = true;
                }
            }
            else
            {
                textBox1.ReadOnly = true;
                button3.Enabled = false;
                label6.Text = "Type";
            }
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            ReloadLists();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ReloadLists();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Config current = (Config)treeView1.SelectedNode.Tag;
            if (current.value != textBox1.Text)
            {
                string newvalue = textBox1.Text.Trim('"', ' ');
                if(current.type == ValueType.String)
                    newvalue = "\"" + newvalue + "\"";
                if (TryToGuessType("placeholder=" + newvalue) == current.type)
                {
                    current.value = newvalue;
                    current.changed = true;
                    if(current.value != GetSelectedConfig().GetTemplate(current).value)
                        treeView1.SelectedNode.NodeFont = new Font("Arial", 8, FontStyle.Underline);
                    else
                        treeView1.SelectedNode.NodeFont = new Font("Arial", 8, FontStyle.Regular);
               //     MessageBoxEx.Show(this, "Value successfully changed. If you are sure you wnat to keep it changed, make sure to hit the save button when existing this dialog.", "Value changed", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                    MessageBoxEx.Show(this, "Type of new value doesnt match the type of this variable.", "Wrong value entered", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
               // MessageBoxEx.Show(this, "Please make some changes first.", "No changes were made", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            bool normal = true;
            foreach (TreeNode n in treeView1.SelectedNode.Parent.Nodes)
            {
                if (((Config)n.Tag).value != GetSelectedConfig().GetTemplate((Config)n.Tag).value)
                {
                    normal = false;
                    break;
                }
            }

            if (!normal)
                treeView1.SelectedNode.Parent.NodeFont = new Font("Arial", 8, FontStyle.Underline);
            else
                treeView1.SelectedNode.Parent.NodeFont = new Font("Arial", 8, FontStyle.Regular);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            foreach (ServerConfig s in configurations)
                if(HasChanges(s))
                    s.Save();
            DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        public bool HasChanges(ServerConfig c)
        {
            foreach (ConfigSection s in c.actual)
            {
                foreach (Config conf in s.configs)
                    if (conf.changed)
                        return true;
            }
            return false;
        }

        public bool HasBeenChanged(string name)
        {
            foreach (ServerConfig s in configurations)
            {
                if (s.name.Replace(".conf", "") == name)
                    return HasChanges(s);
            }

            return false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DialogResult = System.Windows.Forms.DialogResult.Cancel;
        }
    }

    public class ConfigSection
    {
        public string name;
        public List<Config> configs = new List<Config>();

        public ConfigSection(string name)
        {
            this.name = name;
        }
    }

    public class Config
    {
        public string name, description, important, example, value, range;
        public List<string> def = new List<string>();
        public bool visible = true, changed = false;
        public ValueType type;

        public Config(string name)
        {
            this.name = name;
            this.description = "";
            this.important = "";
            this.example = "";
            this.value = null;
            this.range = "";
        }

        public void AddDefault(string def)
        {
            this.def.Add(def);
        }

        public List<FlowLayoutPanel> GetInfoGui()
        {
            List<FlowLayoutPanel> result = new List<FlowLayoutPanel>();
            if (description != "")
                result.Add(ConstructInfo("Description:", description));
            if (range != "")
                result.Add(ConstructInfo("Range:", range));
            if (important != "")
                result.Add(ConstructInfo("Important:", important));
            if (example != "")
                result.Add(ConstructInfo("Example:", example));
            if (def.Count > 0)
                result.Add(ConstructInfo("Default:", def));

            return result;
        }

        private FlowLayoutPanel ConstructInfo(string header, List<string> info)
        {
            FlowLayoutPanel result = new FlowLayoutPanel();
            result.AutoSize = true;
            result.MaximumSize = new Size(250, 2000);
            result.MinimumSize = new Size(250, 20);
            Label l1 = new Label();
            l1.Font = new Font("Arial", 8, FontStyle.Bold);
            l1.AutoSize = false;
            l1.Size = new Size(270, 20);
            l1.TextAlign = ContentAlignment.MiddleLeft;
            l1.Text = header;
            result.Controls.Add(l1);
            foreach (string s in info)
            {
                Label l2 = new Label();
                l2.Font = new Font("Arial", 7, FontStyle.Regular);
                l2.AutoSize = true;
                l2.MinimumSize = new Size(255, 10);
                l2.MaximumSize = new Size(255, 2000);
                l2.Padding = new Padding(10, 2, 2, 2);
                l2.TextAlign = ContentAlignment.TopLeft;
                l2.Text = s;
                result.Controls.Add(l2);
            }
            return result;
        }

        private FlowLayoutPanel ConstructInfo(string header, string info)
        {
            List<string> infoList = new List<string>();
            infoList.Add(info);
            return ConstructInfo(header, infoList);
        }
    }

    public class ServerConfig
    {
        public string name;
        ConfigEditor parent;
        List<ConfigSection> template = new List<ConfigSection>();
        public List<ConfigSection> actual = new List<ConfigSection>();

        public ServerConfig(ConfigEditor parent, string name)
        {
            this.name = name;
            this.parent = parent;
            template = parent.ParseConfig("Launcher\\Configs\\Templates\\" + name);
            actual = parent.ParseConfig("Launcher\\Configs\\" + name);
        }

        public Config GetTemplate(Config c)
        {
            foreach (ConfigSection s in template)
            {
                foreach (Config sc in s.configs)
                    if (sc.name == c.name)
                        return sc;
            }

            return null;
        }

        public void Save()
        {
            using (StreamWriter writer = new StreamWriter("Launcher\\Configs\\" + name, false))
            {
                writer.WriteLine("[worldserver]");
                foreach (ConfigSection s in actual)
                {
                    writer.WriteLine("###################################################################################################");
                    writer.WriteLine("# " + RemoveBreaks(s.name));

                    foreach (Config c in s.configs)
                    {
                        writer.WriteLine("#");
                        writer.WriteLine("#    " + c.name);
                        if (c.description != "")
                        {
                            writer.Write("#       Description:      ");
                            int counter = 26;
                            foreach (char chr in RemoveBreaks(c.description))
                            {
                                counter++;
                                if (counter == 100)
                                {
                                    counter = 26;
                                    writer.Write(Environment.NewLine + "#                         ");
                                }

                                writer.Write(chr);
                            }
                            writer.Write(Environment.NewLine);
                        }

                        if (c.example != "")
                        {
                            writer.Write("#       Example:          ");
                            int counter = 26;
                            foreach (char chr in RemoveBreaks(c.example))
                            {
                                counter++;
                                if (counter == 100)
                                {
                                    counter = 26;
                                    writer.Write(Environment.NewLine + "#                         ");
                                }

                                writer.Write(chr);
                            }
                            writer.Write(Environment.NewLine);
                        }

                        if (c.important != "")
                        {
                            writer.Write("#       Important:        ");
                            int counter = 26;
                            foreach (char chr in RemoveBreaks(c.important))
                            {
                                counter++;
                                if (counter == 100)
                                {
                                    counter = 26;
                                    writer.Write(Environment.NewLine + "#                         ");
                                }

                                writer.Write(chr);
                            }
                            writer.Write(Environment.NewLine);
                        }

                        if (c.range != "")
                        {
                            writer.Write("#       Range:            ");
                            int counter = 26;
                            foreach (char chr in RemoveBreaks(c.range))
                            {
                                counter++;
                                if (counter == 100)
                                {
                                    counter = 26;
                                    writer.Write(Environment.NewLine + "#                         ");
                                }

                                writer.Write(chr);
                            }
                            writer.Write(Environment.NewLine);
                        }

                        if (c.def.Count > 0)
                        {
                            writer.Write("#       Default:          ");
                            int counter = 26;
                            bool first = true;
                            foreach (string st in c.def)
                            {
                                string st2 = RemoveBreaks(st);
                                if (st2 != "")
                                {
                                    if (first)
                                        first = false;
                                    else
                                    {
                                        writer.Write(Environment.NewLine + "#                         ");
                                        counter = 26;
                                    }


                                    foreach (char chr in st2)
                                    {
                                        counter++;
                                        if (counter == 100)
                                        {
                                            counter = 26;
                                            writer.Write(Environment.NewLine + "#                         ");
                                        }

                                        writer.Write(chr);
                                    }
                                }
                            }
                        }

                        writer.WriteLine("");
                        writer.WriteLine("");
                        writer.Write(c.name + " = ");
                        string value = c.value;
                        if (c.type == ValueType.String)
                            value = "\"" + value + "\"";
                        writer.Write(value + Environment.NewLine + Environment.NewLine);
                            
                    }

                    writer.WriteLine("#");
                    writer.WriteLine("###################################################################################################");
                    writer.WriteLine(" ");
                }
            }
        }

        private string RemoveBreaks(string s)
        {
            return s.Replace("\r\n", "").Replace("\n", "").Replace("\r", "");
        }
    }

    public enum ValueType
    {
        Generic,
        Int,
        Float,
        String
    }

    public enum Section
    {
        Name,
        Description,
        Important,
        Example,
        Default,
        Value,
        None,
        Range
    }
}
