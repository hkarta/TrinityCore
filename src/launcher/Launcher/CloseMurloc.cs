using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.Media;
using System.Threading;

namespace Launcher
{
    public partial class CloseMurloc : Form
    {
        BackgroundWorker terminator;
        List<Process> processesToKill;

        public CloseMurloc(List<Process> processesToKill)
        {
            InitializeComponent();
            this.processesToKill = processesToKill;
        }

        private void CloseMurloc_Load(object sender, EventArgs e)
        {
            /*SoundPlayer simpleSound = new SoundPlayer("murloc.wav");
            simpleSound.Play();*/

            terminator = new BackgroundWorker();
            terminator.DoWork += new DoWorkEventHandler(terminator_DoWork);
            terminator.RunWorkerCompleted += new RunWorkerCompletedEventHandler(terminator_RunWorkerCompleted);
            terminator.ProgressChanged += new ProgressChangedEventHandler(terminator_ProgressChanged);
            terminator.WorkerReportsProgress = true;
            progressBar1.Value = 0;
            progressBar1.Maximum = processesToKill.Count * 3;

            terminator.RunWorkerAsync(processesToKill);
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
            DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        void terminator_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            List<Process> processesToKill = e.Argument as List<Process>;
            foreach (Process proc in processesToKill)
            {
                int attempt = 0;
                while (!proc.HasExited)
                {
                    attempt++;
                    worker.ReportProgress(attempt, proc.ProcessName + " [" + proc.Id.ToString() + "]");
                    proc.Kill();
                    Thread.Sleep(1000);
                }


                worker.ReportProgress(-attempt, "Next process.");
            }

            SoundPlayer simpleSound = new SoundPlayer("murloc.wav");
            simpleSound.Play();
            Thread.Sleep(2000);
        }
    }
}
