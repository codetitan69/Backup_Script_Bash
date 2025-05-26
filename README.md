# 🚀 Bash Backup Script

---

This project offers a straightforward Bash script designed to **automate the backup of frequently modified files** within a specified directory. It intelligently checks for files changed in the last 24 hours and creates a compressed archive (`.tar.gz`) of them in a designated backup location.

## ✨ Features

* **Selective Backup:** Only backs up files that have been modified in the last 24 hours. This saves significant disk space and backup time. ⏱️
* **Timestamped Archives:** Each backup file is uniquely named with a Unix timestamp. This prevents overwrites and provides clear versioning of your backups. 📅
* **Robust Error Handling:** Includes checks for correct argument usage and ensures that the provided directory paths are valid. 🛑
* **Cron Job Ready:** The script is specifically designed to be easily scheduled as a periodic task using `cron`, making automation a breeze. ⚙️

## 💡 How It Works

The script performs the following logical steps to ensure your data is backed up efficiently:

1.  **Validates Input:** It first ensures that you've provided exactly two directory paths and that both are legitimate, existing directories.
2.  **Generates Filename:** A unique backup filename is created using the current Unix timestamp, guaranteeing no name collisions.
3.  **Identifies Modified Files:** The script navigates to your target directory and uses the `find` command to precisely locate all regular files modified within the last 24 hours.
4.  **Creates Archive:** If any recently modified files are discovered, it then creates a gzipped tar archive (`.tar.gz`) containing the entire target directory.
5.  **Moves Backup:** The newly created archive is then swiftly moved to your specified destination directory.
6.  **No Changes Notification:** If no files have been modified within the last day, it simply prints a helpful message indicating that nothing needed to be backed up.

## 🚀 Usage

### Prerequisites

Before you get started, make sure you have:

* A **Unix-like operating system** (e.g., Linux, macOS, WSL).
* The **`bash` shell** (which is typically pre-installed).
* The **`tar` and `find` utilities** (standard on most systems).

### Running the Script

1.  **Save the script:** Copy the script content and save it into a file, for instance, `backup.sh`.
    ```bash
    # Example: saving the script
    # nano backup.sh
    # (paste script content)
    # Ctrl+O, Ctrl+X
    ```
2.  **Make it executable:** Give the script permission to run.
    ```bash
    chmod +x backup.sh
    ```
3.  **Execute from the command line:** Provide the target directory and the destination directory as arguments.

    ```bash
    ./backup.sh <target_directory_name> <destination_directory_name>
    ```

    * Replace `<target_directory_name>` with the **absolute path** to the directory you wish to back up.
    * Replace `<destination_directory_name>` with the **absolute path** where you want your backups to be stored.

    **Example:**

    ```bash
    ./backup.sh /home/viper/Desktop/GO-LEARN/ /home/viper/Documents/
    ```

    This command will create a backup of recently modified files from `/home/viper/Desktop/GO-LEARN/` and save the archive in `/home/viper/Documents/`.

---

## ⏰ Setting Up a Cron Job

To truly automate your backups, you'll want to schedule your script using `cron`. `cron` is a powerful time-based job scheduler built into Unix-like operating systems.

Here's how you can set it up:

1.  **Open your crontab for editing:**
    The `crontab -e` command opens your personal cron table in your default text editor (often `vi` or `nano`).
    ```bash
    crontab -e
    ```

2.  **Add the cron entry:**
    Append the following line to the end of the file that opens. It's crucial to ensure the path to your `backup.sh` script is its **absolute path** (e.g., `/usr/local/bin/backup.sh`).

    ```cron
    * */6 * * * bash /usr/local/bin/backup.sh /home/viper/Desktop/GO-LEARN/ /home/viper/Documents/
    ```

    Let's dissect this cron expression:

    * `*`: **Minute** (0-59). This means "every minute."
    * `*/6`: **Hour** (0-23). This signifies "every 6th hour." So, the job will trigger at minute `*` past hours 0, 6, 12, and 18.
    * `*`: **Day of Month** (1-31). This means "every day of the month."
    * `*`: **Month** (1-12). This means "every month."
    * `*`: **Day of Week** (0-7, where both 0 and 7 represent Sunday). This means "every day of the week."

    **In plain English:** Your current cron entry will run the script **every minute** during the 0th, 6th, 12th, and 18th hours, every day, every month.

    **💡 Pro Tip for Schedule Refinement:**
    If your intention is for the script to run **only once** at the *beginning* of every 6th hour (e.g., precisely at 00:00, 06:00, 12:00, and 18:00), you should change the minute field from `*` to `0`:

    ```cron
    0 */6 * * * bash /usr/local/bin/backup.sh /home/viper/Desktop/GO-LEARN/ /home/viper/Documents/
    ```

3.  **Save and Exit:**
    After adding the line, save the `crontab` file and exit your editor. `cron` will automatically detect and apply the new schedule.
