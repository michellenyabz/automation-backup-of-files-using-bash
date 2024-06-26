Automating Daily Backups with Cron and Bash Script

Performing daily manual backups of a large number of files in a collaborative environment can be error-prone and can lead to bottlenecks.  The proverb "too many cooks spoil the broth" applies here, highlighting the potential for conflicts when multiple individuals manage backups.

To address this challenge, we can leverage automation through cron jobs and Bash scripting. This approach offers a reliable and streamlined solution for automatic daily backups.

This repository provides the necessary code and scripts to:

1.Identify files that have been modified or created since the last backup.

2.Automate the backup process every 24 hours using cron jobs.
