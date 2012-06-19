using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Read64bitRegistryFrom32bitApp;

namespace Launcher
{
    public partial class Launcher : Form
    {
        List<string[]> servers = new List<string[]>();
        Form1 parent;

        public Launcher(Form1 parent)
        {
            InitializeComponent();
            this.parent = parent;
            LoadServers();
            ProcessWowDir(false);
        }

        public void ProcessWowDir(bool force = true)
        {
            bool passed = false;
            List<WowClient> clients = HelperFunctions.GetWowPath("..\\", GameVersion.WotLK, this, force);
            foreach (WowClient c in clients)
                if (c.version == GameVersion.WotLK)
                {
                    parent.current = c;
                    textBox3.Text = c.path;
                    label5.Text = "Found suitable wow client in following location:";
                    textBox1.Enabled = true;
                    passed = true;
                    break;
                }

            if (!passed)
                parent.current = null;

            if (parent.current == null)
            {
                textBox3.Text = "";
                label5.Text = "Game client not found. Please locate it using the button below.";
                textBox1.Enabled = true;
                DialogResult = System.Windows.Forms.DialogResult.Cancel;
            }

            parent.ProcessWowDir();

            if(parent.current != null)
                label6.Text = HelperFunctions.GetRealmlist(parent.current);
        }

        private void Launcher_Load(object sender, EventArgs e)
        {
            label6.Text = HelperFunctions.GetRealmlist(parent.current);
        }

        public void ValidateServer()
        {
            string[] values = GetByName(listBox1.Items[listBox1.SelectedIndex].ToString());
            if (textBox1.Text.Length > 0 && textBox2.Text.Length > 0)
            {
                button2.Enabled = true;
                button3.Enabled = true;
            }
            else
            {
                button2.Enabled = false;
                button3.Enabled = false;
            }

            if (values[0] != textBox1.Text || values[1] != textBox2.Text)
                button4.Enabled = false;
            else
                button4.Enabled = true;

            if (listBox1.SelectedIndex == 0)
            {
                button3.Enabled = false;
                button1.Enabled = false;
                button4.Enabled = true;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (GetByName(textBox1.Text) == null && GetByIp(textBox2.Text) == null)
            {
                servers.Add(new string[] { textBox1.Text, textBox2.Text });
                SaveServers();
            }
            else
                MessageBoxEx.Show(this, "Server with such name or ip is already defined.", "Already defined", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        public string[] GetByName(string name)
        {
            foreach (string[] s in servers)
            {
                if (s[0] == name)
                    return s;
            }
            return null;
        }

        public string[] GetByIp(string ip)
        {
            foreach (string[] s in servers)
            {
                if (s[1] == ip)
                    return s;
            }
            return null;
        }

        public void DisplayServers()
        {
            listBox1.Items.Clear();
            foreach (string[] s in servers)
            {
                listBox1.Items.Add(s[0]);
            }
            listBox1.SelectedIndex = 0;
        }

        public void LoadServers()
        {
            servers.Clear();
            servers.Add(new string[] { "Localhost", "127.0.0.1" });
            if (File.Exists("Launcher\\Servers.ini"))
            {
                using (StreamReader reader = new StreamReader("Launcher\\Servers.ini"))
                {
                    string buffer = "";
                    while ((buffer = reader.ReadLine()) != null)
                    {
                        string[] split = buffer.Split('#');
                        servers.Add(new string[] { split[0], split[1] });
                    }
                }
            }

            DisplayServers();
        }

        public void SaveServers()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            using (StreamWriter writer = new StreamWriter("Launcher\\Servers.ini"))
            {
                foreach (string[] s in servers)
                {
                    if(s[0] != "Localhost")
                        writer.WriteLine(s[0] + "#" + s[1]);
                }
            }
            DisplayServers();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox1.SelectedIndex == 0)
            {
                button3.Enabled = false;
                button1.Enabled = false;
                textBox1.Text = "";
                textBox2.Text = "";
            }
            else
            {
                button3.Enabled = true;
                button1.Enabled = true;
                string[] values = GetByName(listBox1.Items[listBox1.SelectedIndex].ToString());
                textBox1.Text = values[0];
                textBox2.Text = values[1];
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            ValidateServer();
        }

        private void textBox1_KeyUp(object sender, KeyEventArgs e)
        {
            ValidateServer();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string[] edit = GetByName(listBox1.SelectedItem.ToString());
            if ((GetByName(textBox1.Text) == null || textBox1.Text == listBox1.SelectedItem.ToString())
                && (GetByIp(textBox2.Text) == null || textBox2.Text == edit[1]))
            {
                edit[0] = textBox1.Text;
                edit[1] = textBox2.Text;
                SaveServers();
            }
            else
            {
                textBox1.Text = edit[0];
                textBox2.Text = edit[1];
                MessageBoxEx.Show(this, "Server with such name or ip is already defined.", "Already defined", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (MessageBoxEx.Show(this, "Are you sure you wish to permanently delete this server?", "Are you sure", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                string[] edit = GetByName(listBox1.SelectedItem.ToString());
                servers.Remove(edit);
                SaveServers();
            }

        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (listBox1.SelectedIndex != 0)
                if (MessageBoxEx.Show(this, "Are you sure you wish to change realmlist to other tha local server? You wont be able to play on your local server until you change it back.", "Are you sure", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.No)
                    return;
            string realmlist = HelperFunctions.GetRealmlistPath(parent.current);
            using (StreamWriter writer = new StreamWriter(realmlist, false))
            {
                writer.WriteLine("set realmlist " + GetByName(listBox1.SelectedItem.ToString())[1].Trim());
            }
            label6.Text = HelperFunctions.GetRealmlist(parent.current);
            if (checkBox1.Checked)
            {
                if (Directory.Exists(parent.current.path + "Cache"))
                    Directory.Delete(parent.current.path + "Cache", true);
            }
            checkBox1.Checked = false;
        }

        private void button5_MouseDown(object sender, MouseEventArgs e)
        {
            ProcessWowDir();
        }

        private void button5_Click(object sender, EventArgs e)
        {

        }
    }

    public static class HelperFunctions
    {
        private static string[] gameVersions = new string[] { "enUS", "enGB", "esES", "esMX", "deDE", "frFR", "ruRU", "zhCN", "koKR", "zhTW" };

        public static List<WowClient> GetWowPath(string prefferedPath, GameVersion version, Form parent = null, bool forceManual = false)
        {
            List<WowClient> result = new List<WowClient>();
            bool addManualy = true;
            if (!forceManual)
            {
                if (File.Exists("Launcher\\Launcher.ini"))
                {
                    using (StreamReader reader = new StreamReader("Launcher\\Launcher.ini"))
                    {
                        string buffer = "";
                        while ((buffer = reader.ReadLine()) != null)
                        {
                            switch (buffer.Split('=')[0])
                            {
                                case "wow":
                                    if (buffer.Split('=')[1] == "")
                                        addManualy = false;
                                    else
                                        result.Add(new WowClient(buffer.Split('=')[1], GetGameVersion(buffer.Split('=')[1])));
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }

                result.Add(new WowClient(prefferedPath, GetGameVersion(prefferedPath)));
                string value64 = RegistryWOW6432.GetRegKey64(RegHive.HKEY_LOCAL_MACHINE, @"SOFTWARE\Blizzard Entertainment\World of Warcraft", "InstallPath");
                string value32 = RegistryWOW6432.GetRegKey32(RegHive.HKEY_LOCAL_MACHINE, @"SOFTWARE\Blizzard Entertainment\World of Warcraft", "InstallPath");
                string path = value64;
                if (path == null)
                    path = value32;
                result.Add(new WowClient(path, GetGameVersion(path)));

                foreach (WowClient c in result)
                    if (c.version == version)
                    {
                        using (StreamWriter writer = new StreamWriter("Launcher\\Launcher.ini", false))
                            writer.WriteLine("wow=" + c.path);
                        return result;
                    }

            }

            if (addManualy)
            {
                bool stop = false;
                while (!stop)
                {
                    if (result.Count == 4)
                        stop = true;

                    MessageBoxHelper.PrepToCenterMessageBoxOnForm(parent);
                    FolderBrowserDialog browse = new FolderBrowserDialog();
                    browse.Description = "Please locate directory containing World of Warcraft (" + version.ToString() + ").";

                    if (browse.ShowDialog(parent) == DialogResult.OK)
                    {
                        result.Add(new WowClient(browse.SelectedPath, GetGameVersion(browse.SelectedPath + "\\")));
                        foreach (WowClient c in result)
                            if (c.version == version)
                            {
                                using (StreamWriter writer = new StreamWriter("Launcher\\Launcher.ini", false))
                                    writer.WriteLine("wow=" + c.path + "\\");
                                return result;
                            }
                    }
                    else
                    {
                        if (MessageBoxEx.Show(parent, "You exited the folder browser. Does it mean that you wish to disable these parts of Server Launcher that require World of Warcraft to be installed?", "Wow not located!", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                            == DialogResult.Yes)
                        {
                            using (StreamWriter writer = new StreamWriter("Launcher\\Launcher.ini", false))
                                writer.WriteLine("wow=");
                            stop = true;

                            return result;
                        }
                    }
                }

                bool disable = true;
                foreach (WowClient c in result)
                    if (c.version == version)
                        disable = false;

                if (disable)
                {
                    using (StreamWriter writer = new StreamWriter("Launcher\\Launcher.ini", false))
                        writer.WriteLine("wow=");
                    string errorMessage = "No suitable game client found, following locations were checked:" + Environment.NewLine + Environment.NewLine;
                    foreach (WowClient c in result)
                    {
                        if (c.version == GameVersion.Unknown)
                            errorMessage += "No gameclient found at " + c.path + Environment.NewLine;
                        else
                            errorMessage += "Game client found at" + c.path + " (" + c.version.ToString() + "), but game requires " + GameVersion.WotLK.ToString() + Environment.NewLine;
                    }

                    MessageBoxEx.Show(parent, errorMessage + Environment.NewLine + "Certain features were disabled.", "No suitable game client found", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }

            return result;
        }

        public static string GetGameLocalisation(string path)
        {
            if (Directory.Exists(path + "Data"))
            {
                foreach (string d in Directory.GetDirectories(path + "Data"))
                {
                    foreach (string loc in gameVersions)
                        if (loc.ToLower() == d.Replace(path + "Data\\", "").ToLower())
                            return loc;
                }
            }

            return null;
        }

        public static GameVersion GetGameVersion(string path)
        {
            if (File.Exists(path + "Wow.exe"))
            {
                if (Directory.Exists(path + "Data\\"))
                {
                    string version = GetGameLocalisation(path);
                    if (version == null || (!File.Exists(path + "Data\\common.mpq") && !File.Exists(path + "Data\\world.mpq")))
                        return GameVersion.Unknown;

                    if (File.Exists(path + "Data\\expansion3.mpq") || File.Exists(path + "Data\\expansion2.mpq") || File.Exists(path + "Data\\expansion1.mpq"))
                        return GameVersion.Cataclysm;

                    if (!File.Exists(path + "realmlist.wtf") && !File.Exists(path + "Data\\" + version + "\\realmlist.wtf"))
                        return GameVersion.Unknown;

                    if (File.Exists(path + "Data\\" + version + "\\realmlist.wtf"))
                        return GameVersion.WotLK;

                    if (File.Exists(path + "realmlist.wtf"))
                        return GameVersion.Tbc;
                }
            }
            return GameVersion.Unknown;
        }

        public static string GetRealmlistPath(WowClient client)
        {
            if (client.version == GameVersion.WotLK)
                return client.path + "Data\\" + GetGameLocalisation(client.path) + "\\realmlist.wtf";
            if (client.version == GameVersion.Tbc)
                return client.path + "realmlist.wtf";

            return null;
        }

        public static string GetRealmlist(WowClient client)
        {
            string path = GetRealmlistPath(client);
            if (File.Exists(path))
            {
                using (StreamReader reader = new StreamReader(path))
                {
                    string buffer = "";
                    while ((buffer = reader.ReadLine()) != null)
                    {
                        if (buffer.ToLower().StartsWith("set realmlist"))
                            return buffer.Replace("set realmlist", "").Trim(' ');
                    }
                }
            }
            return null;
        }
    }

    public enum GameVersion
    {
        Unknown,
        Tbc,
        WotLK,
        Cataclysm
    }

    public class WowClient
    {
        public string path;
        public GameVersion version;

        public WowClient(string path, GameVersion version)
        {
            this.path = path;
            this.version = version;
        }
    }
}
