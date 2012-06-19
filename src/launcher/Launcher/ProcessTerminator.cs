using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Diagnostics;
using System.Windows.Forms;
using System.Threading;
using System.Media;

namespace Launcher
{
    public partial class ProcessTerminator : Form
    {
        List<int> ports;
        List<Process> allowedProcesses;
        BackgroundWorker updater;
        BackgroundWorker terminator;
        bool enabled = true;
        bool forced;
        
        public ProcessTerminator(List<int> ports, List<Process> allowedProcesses, bool forced)
        {
            InitializeComponent();
            this.ports = ports;
            this.allowedProcesses = allowedProcesses;
            this.forced = forced;
        }

        private void ProcessTerminator_Load(object sender, EventArgs e)
        {
            UpdatePortsToKill();
            if (!forced)
            {
                SoundPlayer simpleSound = new SoundPlayer("murloc.wav");
                simpleSound.Play();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            label1.Text = "Killing selected processes...";
            label2.Text = "Port murloc is now attempting to rwllrrr processes sentenced to death. Should it fail to do so, you will have to terminate these manualy.";
            pictureBox1.Image = Properties.Resources.ajax_loader_big;

            terminator = new BackgroundWorker();
            terminator.DoWork += new DoWorkEventHandler(terminator_DoWork);
            terminator.RunWorkerCompleted += new RunWorkerCompletedEventHandler(terminator_RunWorkerCompleted);
            terminator.ProgressChanged += new ProgressChangedEventHandler(terminator_ProgressChanged);
            terminator.WorkerReportsProgress = true;
            progressBar1.Value = 0;
            progressBar1.Maximum = GetPortsToKill().Count * 3;

            DisableForm();

            terminator.RunWorkerAsync(GetPortsToKill());
        }

        void terminator_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            if (e.ProgressPercentage > 0)
                progressBar1.Value++;
            else
                progressBar1.Value += 3 + e.ProgressPercentage;

            label1.Text = (string)e.UserState;
        }

        void terminator_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            EnableForm();
            UpdatePortsToKill();
        }

        void terminator_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            List<int> portsToKill = e.Argument as List<int>;
            foreach (int i in portsToKill)
            {
                int attempt = 0;
                Process proc;
                while((proc = PortChecker.GetProcess(i)) != null)
                {
                    attempt++;
                    worker.ReportProgress(attempt, proc.ProcessName + " [" + proc.Id.ToString() + "]");
                    try
                    {
                        proc.Kill();
                    }
                    catch { }
                    Thread.Sleep(2000);

                    if (proc.Id == 0)
                        break;
                }


                worker.ReportProgress(-attempt, "Next process.");
            }
        }

        private void UpdatePortsToKill()
        {
            label1.Text = "Checking ports...";
            label2.Text = "Checking required ports, please wait.";
            pictureBox1.Image = Properties.Resources.ajax_loader_big;

            updater = new BackgroundWorker();
            updater.DoWork += new DoWorkEventHandler(updater_DoWork);
            updater.RunWorkerCompleted += new RunWorkerCompletedEventHandler(updater_RunWorkerCompleted);
            updater.ProgressChanged += new ProgressChangedEventHandler(updater_ProgressChanged);
            updater.WorkerReportsProgress = true;
        
            progressBar1.Value = 0;
            progressBar1.Maximum = ports.Count;

            foreach (CheckBox c in flowLayoutPanel1.Controls)
            {
                c.Enabled = false;
                c.Checked = false;
            }

            DisableForm();
            
            updater.RunWorkerAsync(ports);
        }

        public void EnableForm()
        {
            button1.Enabled = true;
            button2.Enabled = true;
            button3.Enabled = true;
            flowLayoutPanel1.Enabled = true;
            label3.Enabled = true;
            enabled = true;
        }

        public void DisableForm()
        {
            button1.Enabled = false;
            button2.Enabled = false;
            button3.Enabled = false;
            label3.Enabled = false;
            flowLayoutPanel1.Enabled = false;
            enabled = false;
        }

        void updater_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            try
            {
                progressBar1.Value++;
                CheckBox b = GetPortBox(e.ProgressPercentage);
                if (e.ProgressPercentage != -1)
                {
                    if (b != null)
                    {
                        b.Enabled = true;
                        //b.Checked = true;
                    }
                    else
                    {
                        CheckBox box = new CheckBox();
                        box.Text = e.ProgressPercentage.ToString() + " [" + ((Process)e.UserState).ProcessName + ", ID:" + ((Process)e.UserState).Id + "]";
                        box.Tag = (Process)e.UserState;
                        box.AutoSize = true;
                        box.CheckedChanged += new EventHandler(box_CheckedChanged);
                        box.Checked = false;
                        flowLayoutPanel1.Controls.Add(box);
                        box.Checked = true;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        void box_CheckedChanged(object sender, EventArgs e)
        {
            if (enabled)
            {
                button1.Enabled = false;

                foreach (CheckBox c in flowLayoutPanel1.Controls)
                    if (c.Checked)
                        button1.Enabled = true;
            }
        }

        void updater_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            EnableForm();
            List<CheckBox> destroy = new List<CheckBox>();
            foreach (CheckBox c in flowLayoutPanel1.Controls)
                if (!c.Enabled)
                    destroy.Add(c);
            foreach (CheckBox c in destroy)
                flowLayoutPanel1.Controls.Remove(c);

            if (flowLayoutPanel1.Controls.Count == 0)
            {
                pictureBox1.Image = Properties.Resources.Vista_clean;
                label3.Enabled = false;
                //panel1.BackColor = Color.Gray;
                button3.Enabled = true;
                label1.Text = "All clear, ready to launch!";
                label2.Text = "All required ports appear to be free." +
                    Environment.NewLine + Environment.NewLine +
                    "You may now start the servers.";

                if (forced)
                    button3.PerformClick();
            }
            else
            {
                pictureBox1.Image = Properties.Resources.error;
                label3.Enabled = true;
                //panel1.BackColor = Color.Black;
                button3.Enabled = false;
                label1.Text = "Errors detected";
                label2.Text = "It appears that there is another process running on one of the required ports." +
                    Environment.NewLine + Environment.NewLine +
                    "In order to launch singleplayer server, its neccessary to terminate these processes." +
                    Environment.NewLine + Environment.NewLine +
                    "Would you like port murloc to rwlrrr these automaticaly?";

                if (forced)
                    button1.PerformClick();
            }

            button1.Enabled = false;

            foreach (CheckBox c in flowLayoutPanel1.Controls)
                if (c.Checked)
                    button1.Enabled = true;
        }

        void updater_DoWork(object sender, DoWorkEventArgs e)
        {
            try
            {
                BackgroundWorker worker = sender as BackgroundWorker;
                foreach (int i in ports)
                {
                    Process proc = PortChecker.GetProcess(i);
                    if (proc != null)
                    {
                        bool skip = false;

                        foreach (Process p in allowedProcesses)
                            if (p.Id == proc.Id)
                                skip = true;

                        if (!skip)
                            worker.ReportProgress(i, proc);
                        else
                            worker.ReportProgress(-1);
                    }
                    else
                        worker.ReportProgress(-1);
                    Thread.Sleep(250);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private List<int> GetPortsToKill()
        {
            List<int> portsToKill = new List<int>();
            foreach (CheckBox ch in flowLayoutPanel1.Controls)
                if (ch.Checked)
                    portsToKill.Add(Convert.ToInt32(ch.Text.Split('[')[0]));
            return portsToKill;
        }

        CheckBox GetPortBox(int port)
        {
            foreach (CheckBox c in flowLayoutPanel1.Controls)
            {
                if (Convert.ToInt32(c.Text.Split('[')[0]) == port)
                    return c;
            }
            return null;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            UpdatePortsToKill();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        private void ProcessTerminator_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (e.CloseReason == CloseReason.UserClosing && e.CloseReason == CloseReason.TaskManagerClosing && !enabled)
                e.Cancel = true;
        }
    }
}
