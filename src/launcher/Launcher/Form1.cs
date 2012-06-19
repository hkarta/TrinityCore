using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using NProcessCaller;
using System.Threading;
using System.Media;
using System.Runtime.InteropServices;
using System.Net.Sockets;
using System.Net;
using System.Text.RegularExpressions;
using System.IO;

namespace Launcher
{
    public partial class Form1 : Form
    {
        #region Defines
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        static extern IntPtr SendMessageTimeout(HandleRef hWnd, int msg, IntPtr wParam, IntPtr lParam, int flags, int timeout, out IntPtr pdwResult);

        const int SMTO_ABORTIFHUNG = 2;

        ProcessCaller mysqlServer;
        public ProcessCaller worldServer;
        ProcessCaller authServer;
        List<string> mysqlServerLog = new List<string>();
        List<string> authServerLog = new List<string>();
        List<string> worldServerLog = new List<string>();
        List<string> worldStages = new List<string>();
        int maxLogLines = 20;
        BackgroundWorker uptimeMonitor;
        WorldCommandTree worldCommands;
        public WowClient current = null;
        bool mysqlStarted = false, authStarted = false, worldStarted = false, starting = false, forcedrestart = false;
        public bool screwWorldPopup = false;
        int mysqlstuck = 0, authstuck = 0, worldstuck = 0;
        #endregion 

        public Form1()
        {
            InitializeComponent();

            #region WorldStartupStages
            worldStages.Add("Loading Trinity strings...");
            worldStages.Add("Initialize data stores...");
            worldStages.Add("Loading GameObject models...");
            worldStages.Add("Loading Game Object Templates...");
            worldStages.Add("Loading Spell Proc Event conditions...");
            worldStages.Add("Loading Item Random Enchantments Table...");
            worldStages.Add("Loading Creature templates...");
            worldStages.Add("Loading Creature Data...");
            worldStages.Add("Loading Creature Addon Data...");
            worldStages.Add("Loading Gameobject Data...");
            worldStages.Add("Loading Quests...");
            worldStages.Add("Game Event Creature Data...");
            worldStages.Add("Vehicle Accessories...");
            worldStages.Add("Quest Area Triggers...");
            worldStages.Add("Player Create Spell Data...");
            worldStages.Add("creature loot templates...");
            worldStages.Add("reference loot templates...");
            worldStages.Add("CreatureEventAI Scripts...");
            worldStages.Add("Loading Transports...");
            #endregion
        }

        #region Enable/DisableFormElements
        public void DisableFormElementsAtStartup()
        {
            button_LaunchOrStopAll.Enabled = false;
            button2.Enabled = false;
            button3.Enabled = false;
            button7.Enabled = false;
            groupBox1.Enabled = false;
        }

        public void EnableFormElementsAfterStartup()
        {
            button_LaunchOrStopAll.Enabled = true;
            button2.Enabled = true;
            button3.Enabled = true;
            button7.Enabled = true;
            groupBox1.Enabled = true;
        }
        #endregion

        #region Startup
        public int GetStartupSteps()
        {
            int toload = 0;
            if (mysqlServer == null || mysqlServer.GetProcess() == null || mysqlServer.GetProcess().HasExited || !mysqlStarted)
                toload++;
            if (authServer == null || authServer.GetProcess() == null || authServer.GetProcess().HasExited || !authStarted)
                toload++;
            if (worldServer == null || worldServer.GetProcess() == null || worldServer.GetProcess().HasExited || !worldStarted)
                toload += worldStages.Count + 1;
            return toload;
        }

        private void LaunchOrStopAll(object sender, EventArgs e)
        {
            List<int> ports = new List<int>();
            ports.Add(3307);
            ports.Add(3724);
            ports.Add(8085);

            if ((string)button_LaunchOrStopAll.Tag == "start")
            {
                ProcessTerminator t = new ProcessTerminator(ports, GetAllowedProcesses(), forcedrestart);

                if (t.ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
                {
                    starting = true;
                    button_LaunchOrStopAll.Tag = "stop";
                    button_LaunchOrStopAll.Text = "Stop";
                    DisableFormElementsAtStartup();
                    progressBar1.Value = 0;
                    progressBar1.Maximum = GetStartupSteps();

                    if (mysqlServer == null || mysqlServer.GetProcess() == null || mysqlServer.GetProcess().HasExited || !mysqlStarted)
                    {
                        richTextBox1.Text = "Launching server..." + Environment.NewLine;
                        mysqlServer = new ProcessCaller(this);
                        mysqlServer.FileName = @"mysql\bin\mysqld.exe";
                        mysqlServer.Arguments = @"--defaults-file=mysql\bin\my.cnf --standalone --console";
                        mysqlServer.StdErrReceived += new DataReceivedHandler(caller_StdErrReceived);
                        mysqlServer.Start();
                    }

                    if (mysqlServer.ready)
                        MySQL_Ready();
                }
            }
            else
            {
                button_LaunchOrStopAll.Tag = "start";
                button2.Enabled = false;
                button3.Enabled = false;
                button_LaunchOrStopAll.Text = "Launch";
                if (new CloseMurloc(GetAllProcesses()).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
                {
                    richTextBox1.Text = "Server stoped";
                    richTextBox2.Text = "Server stoped";
                    richTextBox3.Text = "Server stoped";
                    mysqlStarted = false;
                    authStarted = false;
                    worldStarted = false;
                    if (mysqlServer != null)
                        mysqlServer.Cancel();
                    if (authServer != null)
                        authServer.Cancel();
                    if (worldServer != null)
                        worldServer.Cancel();
                }
            }
        }

        public void CheckStarted()
        {
            if (starting)
            {
                if (mysqlStarted && authStarted && worldStarted)
                {
                    starting = false;
                    EnableFormElementsAfterStartup();
                    forcedrestart = false;
                    AccountValidate();
                }
            }
        }

        #region ProcessStarted
        public void MySQL_Ready()
        {
            mysqlStarted = true;
            CheckStarted();
            if (authServer == null || authServer.GetProcess() == null || authServer.GetProcess().HasExited || !authStarted)
            {
                foreach(RadioButton b in flowLayoutPanel1.Controls)
                    if (b.Checked)
                    {
                        File.Copy("Launcher\\Configs\\" + b.Text + ".conf", "worldServer.conf", true);
                        break;
                    }

                richTextBox3.Text = "Launching server..." + Environment.NewLine;
                authServer = new ProcessCaller(this);
                authServer.FileName = @"authserver.exe";
                authServer.StdOutReceived += new DataReceivedHandler(authServer_StdOutReceived);
                authServer.Start();
            }
            else
                Auth_Ready();
        }

        public void Auth_Ready()
        {
            authStarted = true;
            CheckStarted();
            if (worldServer == null || worldServer.GetProcess() == null || worldServer.GetProcess().HasExited || !worldStarted)
            {
                richTextBox2.Text = "Launching server..." + Environment.NewLine;
                worldServer = new ProcessCaller(this);
                worldServer.FileName = @"worldserver.exe";
                worldServer.StdOutReceived += new DataReceivedHandler(worldServer_StdOutReceived);
                worldServer.Start();
                worldStarted = true;
            }
            else
                World_Ready();
        }

        public void World_Ready()
        {
            worldStarted = true;
            CheckStarted();
            SoundPlayer simpleSound = new SoundPlayer("murloc.wav");
            simpleSound.Play();
        }
        #endregion
        #endregion

        #region ProcessOutputCapture
        void worldServer_StdOutReceived(object sender, NProcessCaller.DataReceivedEventArgs e)
        {
            try
            {
                tabControl1.SelectedIndex = 1;
                string[] split = e.Text.Split('\n');
                for (int x = 0; x < split.Length; x++)
                {
                    worldServerLog.Add(split[x]);
                    if (!worldCommands.finished)
                    {
                        if (worldCommands.CurrentCommand() != null)
                            worldCommands.CurrentCommand().Compare(split[x]);
                    }

                    foreach (string s in worldStages)
                    {
                       if (split[x].Contains(s))
                            progressBar1.Value++;
                    }
                }

                if (worldServerLog.Count >= maxLogLines)
                    worldServerLog.RemoveAt(0);
                richTextBox2.Text = "";
                foreach (string s in worldServerLog)
                    richTextBox2.Text = s + Environment.NewLine + richTextBox2.Text;

                if (e.Text.Contains("WORLD: World initialized")) { worldServer.ready = true; World_Ready(); progressBar1.Value++; };
            }
            catch { worldServer = null; }
        }

        void authServer_StdOutReceived(object sender, NProcessCaller.DataReceivedEventArgs e)
        {
            try
            {
                tabControl1.SelectedIndex = 2;
                string[] split = e.Text.Split('\n');
                for (int x = 0; x < split.Length; x++)
                    authServerLog.Add(split[x]);

                if (authServerLog.Count >= maxLogLines)
                    authServerLog.RemoveAt(0);
                richTextBox3.Text = "";
                foreach (string s in authServerLog)
                    richTextBox3.Text = s + Environment.NewLine + richTextBox3.Text;

                if (e.Text.Contains("The auth server process priority class has been set to HIGH")) { authServer.ready = true; Auth_Ready(); progressBar1.Value++; };
            }
            catch { authServer = null; }
        }

        void caller_StdErrReceived(object sender, NProcessCaller.DataReceivedEventArgs e)
        {
            try
            {
                tabControl1.SelectedIndex = 0;
                string[] split = e.Text.Split('\n');
                for (int x = 0; x < split.Length; x++)
                    mysqlServerLog.Add(split[x]);

                if (mysqlServerLog.Count >= maxLogLines)
                    mysqlServerLog.RemoveAt(0);
                richTextBox1.Text = "";
                foreach (string s in mysqlServerLog)
                    richTextBox1.Text = s + Environment.NewLine + richTextBox1.Text;

                if (e.Text.Contains("ready for connections")) { mysqlServer.ready = true; MySQL_Ready(); progressBar1.Value++; };
            }
            catch { mysqlServer = null; }
        }
        #endregion

        #region GetProcessLists
        public List<Process> GetAllowedProcesses()
        {
            List<Process> result = new List<Process>();
            if (mysqlServer != null && mysqlServer.GetProcess() != null && !mysqlServer.GetProcess().HasExited && mysqlStarted)
                result.Add(mysqlServer.GetProcess());
            if (authServer != null && authServer.GetProcess() != null && !authServer.GetProcess().HasExited && authStarted)
                result.Add(authServer.GetProcess());
            if (worldServer != null && worldServer.GetProcess() != null && !worldServer.GetProcess().HasExited && worldStarted)
                result.Add(worldServer.GetProcess());
            return result;
        }

        public List<Process> GetAllProcesses()
        {
            List<Process> result = new List<Process>();
            if (mysqlServer != null && mysqlServer.GetProcess() != null)
                result.Add(mysqlServer.GetProcess());
            if (authServer != null && authServer.GetProcess() != null)
                result.Add(authServer.GetProcess());
            if (worldServer != null && worldServer.GetProcess() != null)
                result.Add(worldServer.GetProcess());
            return result;
        }
        #endregion

        #region (De)initialiseForm
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            screwWorldPopup = true;
            button7.PerformClick();
            Thread.Sleep(500);

            authStarted = false;
            mysqlStarted = false;
            worldStarted = false;

            if (GetAllProcesses().Count > 0)
            {
                if (new CloseMurloc(GetAllProcesses()).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
                    e.Cancel = false;
                else
                    e.Cancel = true;
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            worldCommands = new WorldCommandTree(this);
            uptimeMonitor = new BackgroundWorker();
            uptimeMonitor.DoWork += new DoWorkEventHandler(uptimeMonitor_DoWork);
            uptimeMonitor.RunWorkerCompleted += new RunWorkerCompletedEventHandler(uptimeMonitor_RunWorkerCompleted);
            uptimeMonitor.RunWorkerAsync();

            foreach (string f in Directory.GetFiles("Launcher\\Configs\\"))
            {
                string s = f.Replace("Launcher\\Configs\\", "");
                if (s.EndsWith(".conf"))
                {
                    RadioButton b = new RadioButton();
                    b.Text = s.Replace(".conf", "");
                    b.AutoSize = true;
                    b.Cursor = Cursors.Hand;
                    b.CheckedChanged += new EventHandler(b_CheckedChanged);
                    flowLayoutPanel1.Controls.Add(b);
                    if (flowLayoutPanel1.Controls.Count == 1)
                        b.Checked = true;
                    else
                        b.Checked = false;
                }
            }
        }

        void b_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton b = sender as RadioButton;
            if (b.Checked)
            {
                if (!worldStarted)
                    File.Copy("Launcher\\Configs\\" + b.Text + ".conf", "worldServer.conf", true);
            }
        }
        #endregion

        #region Restarter
        public void RestartAll()
        {
            mysqlStarted = false;
            worldStarted = false;
            authStarted = false;

            button_LaunchOrStopAll.Tag = "start";
            forcedrestart = true;
            button_LaunchOrStopAll.Text = "Launch";
            button_LaunchOrStopAll.Enabled = true;
            button2.Enabled = false;
            button3.Enabled = false;
            if (GetAllProcesses().Count > 0)
            {
                if (new CloseMurloc(GetAllProcesses()).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
                    button_LaunchOrStopAll.PerformClick();
            }
        }

        public void RestartAuth()
        {
            authStarted = false;
            forcedrestart = true;
            DisableFormElementsAtStartup();
            starting = true;
            List<Process> ath = new List<Process>();
            if (authServer != null && authServer.GetProcess() != null)
                ath.Add(authServer.GetProcess());
            if (new CloseMurloc(ath).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
            {
                progressBar1.Value = 0;
                progressBar1.Maximum = GetStartupSteps();
                List<int> ports = new List<int>();
                ports.Add(3724);
                if (new ProcessTerminator(ports, GetAllowedProcesses(), forcedrestart).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
                {
                    MySQL_Ready();
                }
            }
        }

        public void RestartWorld()
        {
            screwWorldPopup = true;
            button7.PerformClick();
            Thread.Sleep(500);

            worldStarted = false;
            forcedrestart = true;
            DisableFormElementsAtStartup();
            starting = true;
            List<Process> wrld = new List<Process>();
            if (worldServer != null && worldServer.GetProcess() != null)
                wrld.Add(worldServer.GetProcess());
            if (new CloseMurloc(wrld).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
            {
                progressBar1.Value = 0;
                progressBar1.Maximum = GetStartupSteps();
                List<int> ports = new List<int>();
                ports.Add(8085);
                if (new ProcessTerminator(ports, GetAllowedProcesses(), forcedrestart).ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
                {
                    MySQL_Ready();
                }
            }
        }

        void uptimeMonitor_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            try
            {
                string uptime = ""; string uptime2 = ""; string uptime3 = "";
                if (mysqlServer != null && !mysqlServer.GetProcess().HasExited && mysqlStarted)
                {
                    if (IsResponding(mysqlServer.GetProcess()))
                    {
                        mysqlstuck = 0;
                        uptime += "MySQL server is running for " + (DateTime.Now - mysqlServer.GetProcess().StartTime).ToString().Split('.')[0] + " ";
                    }
                    else
                    {
                        if (mysqlstuck > 10)
                            RestartAll();
                        mysqlstuck++;
                        uptime += "MySQL server is stuck for " + mysqlstuck.ToString() + " second(s)";
                    }
                }
                else
                {
                    if (!mysqlStarted)
                        uptime += "MySQL server is stoped ";
                    else
                    {
                        uptime += "MySQL server crashed ";
                        RestartAll();
                    }
                }

                if (authServer != null && !authServer.GetProcess().HasExited && authStarted)
                {
                    if (IsResponding(authServer.GetProcess()))
                    {
                        authstuck = 0;
                        uptime2 += "Authentication server is running for " + (DateTime.Now - authServer.GetProcess().StartTime).ToString().Split('.')[0] + " ";
                    }
                    else
                    {
                        if (authstuck > 10)
                            RestartAuth();
                        authstuck++;
                        uptime2 += "Authentication server is stuck for " + authstuck.ToString() + " second(s)";
                    }
                }
                else
                {
                    if (!authStarted)
                        uptime2 += "Authentication server is stoped ";
                    else
                    {
                        uptime2 += "Authentication server crashed ";
                        RestartAuth();
                    }
                }

                if (worldServer != null && !worldServer.GetProcess().HasExited && worldStarted)
                {
                    flowLayoutPanel1.Enabled = false;
                    label7.Enabled = false;

                    if (IsResponding(worldServer.GetProcess()))
                    {
                        worldstuck = 0;
                        uptime3 += "World server is running for " + (DateTime.Now - worldServer.GetProcess().StartTime).ToString().Split('.')[0] + " ";
                    }
                    else
                    {
                        if (worldstuck > 10)
                            RestartWorld();
                        worldstuck++;
                        uptime3 += "World server is stuck for " + worldstuck.ToString() + " second(s)";
                    }
                }
                else
                {
                    flowLayoutPanel1.Enabled = true;
                    label7.Enabled = true;

                    if (!worldStarted)
                        uptime3 += "World server is stoped ";
                    else
                    {
                        uptime3 += "World server crashed ";
                        RestartWorld();
                    }
                }

                toolStripStatusLabel1.Text = uptime;
                toolStripStatusLabel2.Text = uptime2;
                toolStripStatusLabel3.Text = uptime3;

                if (current != null)
                {
                    string realmlist = HelperFunctions.GetRealmlist(current);
                    if (realmlist == "127.0.0.1" || realmlist == "localhost")
                    {
                        if (mysqlStarted && authStarted && worldStarted)
                        {
                            button3.Enabled = true;
                        }
                        else
                            button3.Enabled = false;
                    }
                    else
                        button3.Enabled = true;
                }
                else
                    button3.Enabled = false;
            }
            catch { }
            uptimeMonitor.RunWorkerAsync();
        }

        bool IsResponding(Process process)
        {
            // not yet implemented
            return true;
        }

        void uptimeMonitor_DoWork(object sender, DoWorkEventArgs e)
        {
            Thread.Sleep(1000);
        }
        #endregion

        private void button2_Click(object sender, EventArgs e)
        {
            RestartWorld();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            label4.Enabled = !checkBox1.Checked;
            button4.Enabled = checkBox1.Checked;
        }

        private void radioButton5_CheckedChanged(object sender, EventArgs e)
        {
            account_name.Text = "";
            account_pass.Text = "";
            account_gm.Checked = false;

            if (radioButton3.Checked || radioButton5.Checked)
            {
                label3.Enabled = true;
                account_pass.Enabled = true;
            }
            else
            {
                label3.Enabled = false;
                account_pass.Enabled = false;
            }

            if (radioButton4.Checked)
                account_gm.Enabled = false;
            else
                account_gm.Enabled = true;
        }

        private void account_name_KeyUp(object sender, KeyEventArgs e)
        {
            AccountValidate();
        }

        private void account_pass_TextChanged(object sender, EventArgs e)
        {
            AccountValidate();
        }

        public void AccountValidate()
        {
            if (worldServer != null && !worldServer.GetProcess().HasExited && worldStarted)
            {
                account_name.Text = convertString(account_name.Text);
                account_pass.Text = convertString(account_pass.Text);

                bool passed = true;
                if (account_name.Enabled && account_name.Text.Length == 0)
                    passed = false;

                if (!radioButton5.Checked)
                {
                    if (account_pass.Enabled && account_pass.Text.Length == 0)
                        passed = false;
                }

                button1.Enabled = passed;


            }
            else
                button1.Enabled = false;
        }

        public static string convertString(string phrase)
        {
            Regex rgx = new Regex("[^a-zA-Z0-9]");
            return rgx.Replace(phrase, "");
        }

        private void button1_Click(object sender, EventArgs e)
        {
          //  worldServer.
            if (worldCommands.finished)
            {
                if (radioButton3.Checked)
                {

                    WorldCommandTree commandtree = new WorldCommandTree(this);
                    commandtree.finished = false;

                    List<string[]> expectedValues = new List<string[]>();
                    expectedValues.Add(new string[] { "Account created:", "Account successfully created." });
                    expectedValues.Add(new string[] { "Account with this name already exist!", "Such account already exists!" });
                    expectedValues.Add(new string[] { "Syntax: .account create $account $password", "Wrong syntax!" });
                    WorldCommand create = new WorldCommand("account create " + account_name.Text + " " + account_pass.Text, expectedValues, commandtree);
                    commandtree.AddCommand(create);

                    List<string[]> expectedValues2 = new List<string[]>();
                    expectedValues2.Add(new string[] { " have up to 2 expansion allowed now.", "Expansion set to Wrath of the Lich King" });
                    expectedValues2.Add(new string[] { "Account not exist:", "Such account doesnt exist!" }); // as well for for account set password acc pass pass
                    WorldCommand create2 = new WorldCommand("account set addon " + account_name.Text + " 2", expectedValues2, commandtree);
                    commandtree.AddCommand(create2); //

                    List<string[]> expectedValues3 = new List<string[]>();
                    expectedValues3.Add(new string[] { "You change security level of account", "Security level changed." });

                    WorldCommand create3;
                    if (account_gm.Checked)
                        create3 = new WorldCommand("account set gm " + account_name.Text + " 3 -1", expectedValues3, commandtree);
                    else
                        create3 = new WorldCommand("account set gm " + account_name.Text + " 0 -1", expectedValues3, commandtree);

                    commandtree.AddCommand(create3);

                    commandtree.Initialise();

                    worldCommands = commandtree;
                }
                else if (radioButton5.Checked)
                {
                    WorldCommandTree commandtree = new WorldCommandTree(this);
                    commandtree.finished = false;

                    if (account_pass.Text.Length > 0)
                    {
                        List<string[]> expectedValues2 = new List<string[]>();
                        expectedValues2.Add(new string[] { "The password was changed", "The password was changed" });
                        expectedValues2.Add(new string[] { "Account not exist:", "Such account doesnt exist!" }); // as well for for account set password acc pass pass
                        WorldCommand create2 = new WorldCommand("account set password " + account_name.Text + " " + account_pass.Text + " " + account_pass.Text, expectedValues2, commandtree);
                        commandtree.AddCommand(create2); //
                    }

                    List<string[]> expectedValues3 = new List<string[]>();
                    expectedValues3.Add(new string[] { "You change security level of account", "Security level changed." });

                    WorldCommand create3;
                    if (account_gm.Checked)
                        create3 = new WorldCommand("account set gm " + account_name.Text + " 3 -1", expectedValues3, commandtree);
                    else
                        create3 = new WorldCommand("account set gm " + account_name.Text + " 0 -1", expectedValues3, commandtree);

                    commandtree.AddCommand(create3);

                    commandtree.Initialise();

                    worldCommands = commandtree;
                }
                else if (radioButton4.Checked)
                {
                    if (MessageBoxEx.Show(this, "Are you sure you want to permanently delete account '" + account_name.Text + "' and all of the characters it contains?", "Are you sure?", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                    {
                        WorldCommandTree commandtree = new WorldCommandTree(this);
                        commandtree.finished = false;

                        List<string[]> expectedValues2 = new List<string[]>();
                        expectedValues2.Add(new string[] { "Account deleted:", "Account deleted" });
                        expectedValues2.Add(new string[] { "Account not exist:", "Such account doesnt exist!" }); // as well for for account set password acc pass pass
                        WorldCommand create2 = new WorldCommand("account delete " + account_name.Text, expectedValues2, commandtree);
                        commandtree.AddCommand(create2); 

                        commandtree.Initialise();

                        worldCommands = commandtree;
                    }    
                }

                account_gm.Checked = false;
                account_name.Text = "";
                account_pass.Text = "";
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (worldCommands.finished)
            {
                WorldCommandTree commandtree = new WorldCommandTree(this);
                commandtree.finished = false;

                List<string[]> expectedValues = new List<string[]>();
                expectedValues.Add(new string[] { "All players saved.", "All players saved." });
                WorldCommand create = new WorldCommand("saveall", expectedValues, commandtree);
                commandtree.AddCommand(create);
                commandtree.Initialise();

                worldCommands = commandtree;
            }
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            new ConfigEditor().Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            ConfigEditor confed = new ConfigEditor();
            if (confed.ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
            {
                if (worldServer != null && !worldServer.GetProcess().HasExited && worldStarted)
                {
                    foreach (RadioButton b in flowLayoutPanel1.Controls)
                        if (b.Checked && confed.HasBeenChanged(b.Text))
                        {
                            File.Copy("Launcher\\Configs\\" + b.Text + ".conf", "worldServer.conf", true);
                            ReloadConfig();
                            break;//Re-Loading config settings...
                        }
                }
            }
        }

        public void ReloadConfig()
        {
            if (worldCommands.finished)
            {
                WorldCommandTree commandtree = new WorldCommandTree(this);
                commandtree.finished = false;

                List<string[]> expectedValues = new List<string[]>();
                expectedValues.Add(new string[] { "Re-Loading config settings...", "Config reloaded" });
                WorldCommand create = new WorldCommand("reload config", expectedValues, commandtree);
                commandtree.AddCommand(create);
                commandtree.Initialise();

                worldCommands = commandtree;
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Launcher lchr = new Launcher(this);
            if (lchr.ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
            {

            }
        }

        private void Form1_Shown(object sender, EventArgs e)
        {
            ProcessWowDir();
        }

        public void ProcessWowDir()
        {
            List<WowClient> clients = HelperFunctions.GetWowPath("..\\", GameVersion.WotLK, this);
            foreach (WowClient c in clients)
                if (c.version == GameVersion.WotLK)
                {
                    current = c;
                    textBox1.Text = c.path;
                    label5.Text = "Found suitable wow client in following location:";
                    button5.Enabled = false;
                    button6.Enabled = true;
                    textBox1.Enabled = false;
                    break;
                }

            if (current == null)
            {
                textBox1.Text = "";
                label5.Text = "Game client not found. Please locate it using the button below.";
                button5.Enabled = true;
                button6.Enabled = false;
                textBox1.Enabled = true;
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            if(File.Exists("Launcher\\Launcher.ini"))
                File.Delete("Launcher\\Launcher.ini");
            ProcessWowDir();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if(current != null)
                Process.Start(current.path);
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            if (mysqlStarted)
            {
                if (MessageBoxEx.Show(this, "WARNING: Do not try to edit anything in database, unless you know what you are doing! You can easily cause great harm to your server!" + Environment.NewLine +
                    Environment.NewLine + "Are you ABSOLUTELY sure you want to start MySQL GUI?", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == System.Windows.Forms.DialogResult.Yes)
                {
                    Process proc = new Process();
                    proc.StartInfo = new ProcessStartInfo("Tools\\heidisql.exe", "-h=localhost -u=root -p=ascent -P=3307");
                    proc.Start();
                }
            }
            else
                MessageBoxEx.Show(this, "Please launch the server first!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }

    public class WorldCommandTree
    {
        public bool finished = true;
        Form1 parent;
        int currentcommand = -1;
        string result = "";
        List<WorldCommand> commands = new List<WorldCommand>();

        public WorldCommandTree(Form1 parent) 
        {
            this.parent = parent;
        }

        public void Initialise()
        {
            finished = false;
            Next("World command result:" + Environment.NewLine);
        }

        public void Next(string result)
        {
            if(currentcommand == -1)
                this.result += result + Environment.NewLine;
            else
                this.result += "Command: " + CurrentCommand().command + Environment.NewLine + ">> " + result + Environment.NewLine + Environment.NewLine;
            if (currentcommand + 1 < commands.Count)
            {
                currentcommand++;
                parent.worldServer.Input(commands[currentcommand].command);
            }
            else
            {
                if (!parent.screwWorldPopup)
                {
                    MessageBoxEx.Show(parent, this.result, "Done", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    finished = true;
                }
                parent.screwWorldPopup = false;
            }
        }

        public void Error(string result)
        {
            if (!parent.screwWorldPopup)
            {
                this.result += result + Environment.NewLine;
                MessageBoxEx.Show(parent, this.result, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                finished = true;
            }
            parent.screwWorldPopup = false;
        }

        public WorldCommand CurrentCommand()
        {
            if (currentcommand >= 0)
                return commands[currentcommand];
            else
                return null;
        }

        public void AddCommand(WorldCommand command)
        {
            commands.Add(command);
        }
    }

    public class WorldCommand
    {
        public string command;
        List<string[]> results;
        WorldCommandTree parent;

        public WorldCommand(string command, List<string[]> results, WorldCommandTree parent)
        {
            this.command = command;
            this.results = results;
            this.parent = parent;
        }

        public void Compare(string text)
        {
            for (int x = 0; x < results.Count; x++)
            {
                if (text.Contains(results[x][0]))
                {
                    if (x == 0)
                        parent.Next(text);
                    else
                        parent.Error(results[x][1]);
                }
            }
        }
    }
}
