$Global:PasswordVerified = $false

function check-password {
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "رمز عبور برای ورود"
    $form.Width = 350
    $form.Height = 160
    $form.FormBorderStyle = 'FixedDialog'
    $form.StartPosition = "CenterScreen"
    $form.Topmost = $true

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "رمز عبور را وارد کنید:"
    $label.Top = 20
    $label.Left = 20
    $label.Width = 280
    $form.Controls.Add($label)

    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Top = 50
    $textbox.Left = 20
    $textbox.Width = 290
    $textbox.UseSystemPasswordChar = $true
    $form.Controls.Add($textbox)

    $button = New-Object System.Windows.Forms.Button
    $button.Text = "ورود"
    $button.Top = 80
    $button.Left = 120
    $button.Width = 100
    $form.Controls.Add($button)

    $button.Add_Click({
        if ($textbox.Text -eq "1684") {
            $Global:PasswordVerified = $true
            $form.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("رمز اشتباه است!", "خطا")
            $textbox.Clear()
        }
    })

    $form.ShowDialog()
}

check-password

if (-not $Global:PasswordVerified) {
    Write-Host "❌ دسترسی غیرمجاز. افزونه غیرفعال شد." -ForegroundColor Red
    return
}

function hacker-on {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Hacker UI"
    $form.BackColor = 'Black'
    $form.ForeColor = 'Lime'
    $form.Width = 1000
    $form.Height = 700
    $form.FormBorderStyle = 'FixedDialog'
    $form.KeyPreview = $true
    $form.StartPosition = "CenterScreen"

    $font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Regular)

    $box1 = New-Object System.Windows.Forms.TextBox
    $box1.Multiline = $true
    $box1.ScrollBars = "Vertical"
    $box1.ReadOnly = $true
    $box1.BackColor = 'Black'
    $box1.ForeColor = 'Lime'
    $box1.Font = $font
    $box1.Width = 480
    $box1.Height = 300
    $box1.Location = New-Object System.Drawing.Point(10,10)
    $form.Controls.Add($box1)

    $box2 = New-Object System.Windows.Forms.TextBox
    $box2.Multiline = $true
    $box2.ScrollBars = "Vertical"
    $box2.ReadOnly = $true
    $box2.BackColor = 'Black'
    $box2.ForeColor = 'Lime'
    $box2.Font = $font
    $box2.Width = 480
    $box2.Height = 300
    $box2.Location = New-Object System.Drawing.Point(500,10)
    $form.Controls.Add($box2)

    $box3 = New-Object System.Windows.Forms.TextBox
    $box3.Multiline = $true
    $box3.ReadOnly = $true
    $box3.BackColor = 'Black'
    $box3.ForeColor = 'Lime'
    $box3.Font = $font
    $box3.Width = 970
    $box3.Height = 300
    $box3.Location = New-Object System.Drawing.Point(10,320)
    $form.Controls.Add($box3)

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 200
    $timer.Add_Tick({
        $box1.AppendText(">> Cracking password " + (Get-Random -Minimum 100000 -Maximum 999999) + "`r`n")
        if ($box1.Lines.Count -gt 20) { $box1.Clear() }

        $matrix = ""
        1..10 | ForEach-Object {
            $line = -join ((48..90) + (97..122) | Get-Random -Count 40 | ForEach-Object {[char]$_})
            $matrix += "$line`r`n"
        }
        $box2.Text = $matrix

        $chart = ""
        1..30 | ForEach-Object {
            $val = Get-Random -Minimum 1 -Maximum 40
            $chart += ("█" * $val).PadRight(40) + "`r`n"
        }
        $box3.Text = $chart
    })
    $timer.Start()

    $form.Add_KeyDown({
        if ($_.KeyCode -eq 'Escape') {
            $timer.Stop()
            $form.Close()
        }
    })

    $form.ShowDialog()
}

function explor-on {
    Add-Type -AssemblyName System.Windows.Forms

    $folders = Get-ChildItem -Directory -Path (Get-Location)
    if ($folders.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("هیچ فولدری در این مسیر وجود ندارد.", "اطلاع")
        return
    }

    $selected = $folders | Out-GridView -Title "Select folder to open" -PassThru
    if ($selected) {
        Invoke-Item $selected.FullName
    }
}
function taskm {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object Windows.Forms.Form
    $form.Text = "Task Manager"
    $form.Width = 400
    $form.Height = 200
    $form.StartPosition = "CenterScreen"
    $form.TopMost = $true
    $form.KeyPreview = $true

    $labelCPU = New-Object Windows.Forms.Label
    $labelCPU.Text = "CPU Usage: "
    $labelCPU.Top = 20
    $labelCPU.Left = 20
    $labelCPU.Width = 350
    $form.Controls.Add($labelCPU)

    $labelRAM = New-Object Windows.Forms.Label
    $labelRAM.Text = "RAM Usage: "
    $labelRAM.Top = 60
    $labelRAM.Left = 20
    $labelRAM.Width = 350
    $form.Controls.Add($labelRAM)

    $cpuCounter = New-Object System.Diagnostics.PerformanceCounter("Processor", "% Processor Time", "_Total")
    $ramCounter = New-Object System.Diagnostics.PerformanceCounter("Memory", "Available MBytes")

    $totalMemory = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB

    $timer = New-Object Windows.Forms.Timer
    $timer.Interval = 1000
    $timer.Add_Tick({
        $cpu = [math]::Round($cpuCounter.NextValue(), 1)
        $ramFree = $ramCounter.NextValue()
        $ramUsed = [math]::Round($totalMemory - $ramFree, 1)
        $ramPercent = [math]::Round(($ramUsed / $totalMemory) * 100, 1)

        $labelCPU.Text = "CPU Usage: $cpu %"
	$labelRAM.Text = "RAM Usage: $ramUsed MB ($ramPercent%)"

    })
    $timer.Start()

    $form.Add_KeyDown({
        if ($_.KeyCode -eq 'Escape') {
            $timer.Stop()
            $form.Close()
        }
    })

    $form.ShowDialog()
}
function history-on {
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "تاریخچه دستورات"
    $form.Width = 600
    $form.Height = 400
    $form.StartPosition = "CenterScreen"

    $listbox = New-Object System.Windows.Forms.ListBox
    $listbox.Dock = "Fill"
    $listbox.Font = 'Consolas,10'
    $form.Controls.Add($listbox)

    # بارگذاری تاریخچه دستورات
    $history = Get-History | Sort-Object Id -Descending | Select-Object -First 50
    foreach ($item in $history) {
        $listbox.Items.Add($item.CommandLine)
    }

    $listbox.Add_DoubleClick({
        $selected = $listbox.SelectedItem
        if ($selected) {
            $form.Close()
            Invoke-Expression $selected
        }
    })

    $form.ShowDialog()
}
function reminder-on {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $reminderFile = "$PSScriptRoot\reminders.json"
    if (-not (Test-Path $reminderFile)) {
        '{}' | Out-File -Encoding utf8 $reminderFile
    }

    $reminders = Get-Content $reminderFile | ConvertFrom-Json

    $form = New-Object Windows.Forms.Form
    $form.Text = "تقویم یادآور"
    $form.Width = 400
    $form.Height = 300
    $form.StartPosition = "CenterScreen"

    $calendar = New-Object Windows.Forms.MonthCalendar
    $calendar.MaxSelectionCount = 1
    $calendar.Location = New-Object Drawing.Point(10,10)
    $form.Controls.Add($calendar)

    $textBox = New-Object Windows.Forms.TextBox
    $textBox.Multiline = $true
    $textBox.Width = 360
    $textBox.Height = 80
    $textBox.Location = New-Object Drawing.Point(10,180)
    $form.Controls.Add($textBox)

    $button = New-Object Windows.Forms.Button
    $button.Text = "ذخیره یادداشت"
    $button.Width = 120
    $button.Height = 30
    $button.Location = New-Object Drawing.Point(140, 230)
    $form.Controls.Add($button)

    # هنگام انتخاب روز، یادداشت قبلی را نمایش دهد
    $calendar.Add_DateSelected({
        $selectedDate = $calendar.SelectionStart.ToString("yyyy-MM-dd")
        if ($reminders.$selectedDate) {
            $textBox.Text = $reminders.$selectedDate
        } else {
            $textBox.Clear()
        }
    })

    $button.Add_Click({
        $selectedDate = $calendar.SelectionStart.ToString("yyyy-MM-dd")
        $reminders[$selectedDate] = $textBox.Text
        $reminders | ConvertTo-Json -Depth 3 | Set-Content -Path $reminderFile -Encoding utf8
        [System.Windows.Forms.MessageBox]::Show("یادداشت ذخیره شد برای $selectedDate", "موفقیت")
    })

    $form.ShowDialog()
}
function secure-on {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Security

    function Encrypt-File {
        param($Path, $Password)
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $aes = [System.Security.Cryptography.Aes]::Create()
        $salt = New-Object byte[] 16
        [System.Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($salt)
        $key = New-Object byte[] 32
        $iv = New-Object byte[] 16
        $rfc = New-Object System.Security.Cryptography.Rfc2898DeriveBytes($Password, $salt, 10000)
        $key = $rfc.GetBytes(32)
        $iv = $rfc.GetBytes(16)
        $aes.Key = $key
        $aes.IV = $iv
        $ms = New-Object IO.MemoryStream
        $ms.Write($salt, 0, $salt.Length)
        $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $aes.CreateEncryptor(), 'Write')
        $cs.Write($bytes, 0, $bytes.Length)
        $cs.Close()
        [System.IO.File]::WriteAllBytes($Path + ".enc", $ms.ToArray())
        Remove-Item $Path
    }

    function Decrypt-File {
        param($Path, $Password)
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $salt = $bytes[0..15]
        $data = $bytes[16..($bytes.Length - 1)]
        $aes = [System.Security.Cryptography.Aes]::Create()
        $rfc = New-Object System.Security.Cryptography.Rfc2898DeriveBytes($Password, $salt, 10000)
        $aes.Key = $rfc.GetBytes(32)
        $aes.IV = $rfc.GetBytes(16)
        $ms = New-Object IO.MemoryStream
        $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $aes.CreateDecryptor(), 'Write')
        $cs.Write($data, 0, $data.Length)
        $cs.Close()
        $outputPath = $Path -replace ".enc$", ""
        [System.IO.File]::WriteAllBytes($outputPath, $ms.ToArray())
    }

    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Title = "انتخاب فایل برای رمزگذاری یا رمزگشایی"
    if ($ofd.ShowDialog() -eq "OK") {
        $file = $ofd.FileName

        $form = New-Object System.Windows.Forms.Form
        $form.Text = "رمزگذاری یا رمزگشایی"
        $form.Width = 300
        $form.Height = 180
        $form.StartPosition = "CenterScreen"

        $label = New-Object System.Windows.Forms.Label
        $label.Text = "رمز عبور را وارد کنید:"
        $label.Top = 20
        $label.Left = 20
        $form.Controls.Add($label)

        $textbox = New-Object System.Windows.Forms.TextBox
        $textbox.Left = 20
        $textbox.Top = 50
        $textbox.Width = 240
        $textbox.UseSystemPasswordChar = $true
        $form.Controls.Add($textbox)

        $encryptBtn = New-Object System.Windows.Forms.Button
        $encryptBtn.Text = "رمزگذاری"
        $encryptBtn.Top = 90
        $encryptBtn.Left = 30
        $form.Controls.Add($encryptBtn)

        $decryptBtn = New-Object System.Windows.Forms.Button
        $decryptBtn.Text = "رمزگشایی"
        $decryptBtn.Top = 90
        $decryptBtn.Left = 140
        $form.Controls.Add($decryptBtn)

        $encryptBtn.Add_Click({
            Encrypt-File $file $textbox.Text
            [System.Windows.Forms.MessageBox]::Show("رمزگذاری انجام شد و فایل اصلی حذف شد.")
            $form.Close()
        })

        $decryptBtn.Add_Click({
            try {
                Decrypt-File $file $textbox.Text
                [System.Windows.Forms.MessageBox]::Show("رمزگشایی انجام شد.")
            } catch {
                [System.Windows.Forms.MessageBox]::Show("رمز نادرست یا فایل خراب است.", "خطا")
            }
            $form.Close()
        })

        $form.ShowDialog()
    }
}
function project-on {
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "ساخت پروژه جدید"
    $form.Width = 400
    $form.Height = 300
    $form.StartPosition = "CenterScreen"

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Text = "نام پروژه:"
    $label1.Top = 20
    $label1.Left = 20
    $form.Controls.Add($label1)

    $textboxName = New-Object System.Windows.Forms.TextBox
    $textboxName.Top = 40
    $textboxName.Left = 20
    $textboxName.Width = 340
    $form.Controls.Add($textboxName)

    $label2 = New-Object System.Windows.Forms.Label
    $label2.Text = "زبان پروژه:"
    $label2.Top = 70
    $label2.Left = 20
    $form.Controls.Add($label2)

    $comboLang = New-Object System.Windows.Forms.ComboBox
    $comboLang.Items.AddRange(@("Python", "JavaScript", "C#", "HTML", "Rust"))
    $comboLang.Top = 90
    $comboLang.Left = 20
    $comboLang.Width = 200
    $comboLang.DropDownStyle = "DropDownList"
    $comboLang.SelectedIndex = 0
    $form.Controls.Add($comboLang)

    $btnBrowse = New-Object System.Windows.Forms.Button
    $btnBrowse.Text = "انتخاب مسیر..."
    $btnBrowse.Top = 130
    $btnBrowse.Left = 20
    $form.Controls.Add($btnBrowse)

    $selectedPath = ""

    $btnBrowse.Add_Click({
        $fbd = New-Object System.Windows.Forms.FolderBrowserDialog
        if ($fbd.ShowDialog() -eq "OK") {
            $selectedPath = $fbd.SelectedPath
        }
    })

    $btnCreate = New-Object System.Windows.Forms.Button
    $btnCreate.Text = "ساخت پروژه"
    $btnCreate.Top = 170
    $btnCreate.Left = 130
    $form.Controls.Add($btnCreate)

    $btnCreate.Add_Click({
        if (-not $selectedPath -or -not $textboxName.Text) {
            [System.Windows.Forms.MessageBox]::Show("لطفاً نام پروژه و مسیر را وارد کنید.", "خطا")
            return
        }

        $projectName = $textboxName.Text
        $lang = $comboLang.SelectedItem
        $projectPath = Join-Path $selectedPath $projectName

        if (-not (Test-Path $projectPath)) {
            New-Item -Path $projectPath -ItemType Directory | Out-Null
            New-Item "$projectPath\README.md" -ItemType File | Out-Null
            New-Item "$projectPath\.gitignore" -ItemType File | Out-Null
            New-Item "$projectPath\LICENSE" -ItemType File | Out-Null
            New-Item -Path "$projectPath\src" -ItemType Directory | Out-Null
            New-Item -Path "$projectPath\tests" -ItemType Directory | Out-Null
            New-Item -Path "$projectPath\docs" -ItemType Directory | Out-Null

            if ($lang -eq "Python") {
                New-Item "$projectPath\src\main.py" -ItemType File | Out-Null
            } elseif ($lang -eq "JavaScript") {
                New-Item "$projectPath\src\app.js" -ItemType File | Out-Null
            } elseif ($lang -eq "C#") {
                New-Item "$projectPath\src\Program.cs" -ItemType File | Out-Null
            } elseif ($lang -eq "HTML") {
                New-Item "$projectPath\src\index.html" -ItemType File | Out-Null
            } elseif ($lang -eq "Rust") {
                New-Item "$projectPath\src\main.rs" -ItemType File | Out-Null
            }

            [System.Windows.Forms.MessageBox]::Show("✅ پروژه با موفقیت ساخته شد!", "موفقیت")
        } else {
            [System.Windows.Forms.MessageBox]::Show("این پروژه از قبل وجود دارد!", "خطا")
        }
        $form.Close()
    })

    $form.ShowDialog()
}
function sandbox-on {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🧪 Code Sandbox"
    $form.Width = 600
    $form.Height = 500
    $form.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "انتخاب زبان:"
    $label.Top = 10
    $label.Left = 10
    $form.Controls.Add($label)

    $langBox = New-Object System.Windows.Forms.ComboBox
    $langBox.Items.AddRange(@("PowerShell", "Batch", "Python"))
    $langBox.Top = 30
    $langBox.Left = 10
    $langBox.Width = 150
    $langBox.DropDownStyle = "DropDownList"
    $langBox.SelectedIndex = 0
    $form.Controls.Add($langBox)

    $codeBox = New-Object System.Windows.Forms.TextBox
    $codeBox.Multiline = $true
    $codeBox.ScrollBars = "Vertical"
    $codeBox.Top = 60
    $codeBox.Left = 10
    $codeBox.Width = 560
    $codeBox.Height = 320
    $codeBox.Font = 'Consolas,10'
    $form.Controls.Add($codeBox)

    $runBtn = New-Object System.Windows.Forms.Button
    $runBtn.Text = "▶ اجرا"
    $runBtn.Top = 400
    $runBtn.Left = 240
    $form.Controls.Add($runBtn)

    $runBtn.Add_Click({
        $code = $codeBox.Text
        $lang = $langBox.SelectedItem
        $tempPath = "$env:TEMP\sandbox_temp"

        if (-not (Test-Path $tempPath)) {
            New-Item -ItemType Directory -Path $tempPath | Out-Null
        }

        $file = ""
        $cmd = ""

        switch ($lang) {
            "PowerShell" {
                $file = "$tempPath\code.ps1"
                $code | Set-Content $file
                $cmd = "powershell.exe -ExecutionPolicy Bypass -File `"$file`""
            }
            "Batch" {
                $file = "$tempPath\code.bat"
                $code | Set-Content $file -Encoding ASCII
                $cmd = "cmd.exe /c `"$file`""
            }
            "Python" {
                $file = "$tempPath\code.py"
                $code | Set-Content $file
                $cmd = "python `"$file`""
            }
        }

        try {
            $output = Invoke-Expression $cmd 2>&1
        } catch {
            $output = $_.Exception.Message
        }

        $outForm = New-Object System.Windows.Forms.Form
        $outForm.Text = "📤 خروجی کد"
        $outForm.Width = 600
        $outForm.Height = 400
        $outForm.StartPosition = "CenterScreen"

        $outputBox = New-Object System.Windows.Forms.TextBox
        $outputBox.Multiline = $true
        $outputBox.ScrollBars = "Vertical"
        $outputBox.ReadOnly = $true
        $outputBox.Top = 10
        $outputBox.Left = 10
        $outputBox.Width = 560
        $outputBox.Height = 330
        $outputBox.Font = 'Consolas,10'
        $outputBox.Text = $output
        $outForm.Controls.Add($outputBox)

        $outForm.ShowDialog()
    })

    $form.ShowDialog()
}
function alarm-on {
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "⏰ تنظیم هشدار"
    $form.Width = 400
    $form.Height = 220
    $form.StartPosition = "CenterScreen"

    $labelTime = New-Object System.Windows.Forms.Label
    $labelTime.Text = "زمان هشدار (hh:mm):"
    $labelTime.Top = 20
    $labelTime.Left = 20
    $form.Controls.Add($labelTime)

    $timeInput = New-Object System.Windows.Forms.MaskedTextBox
    $timeInput.Mask = "00:00"
    $timeInput.Top = 40
    $timeInput.Left = 20
    $timeInput.Width = 100
    $form.Controls.Add($timeInput)

    $labelMsg = New-Object System.Windows.Forms.Label
    $labelMsg.Text = "متن هشدار:"
    $labelMsg.Top = 70
    $labelMsg.Left = 20
    $form.Controls.Add($labelMsg)

    $msgBox = New-Object System.Windows.Forms.TextBox
    $msgBox.Top = 90
    $msgBox.Left = 20
    $msgBox.Width = 340
    $form.Controls.Add($msgBox)

    $button = New-Object System.Windows.Forms.Button
    $button.Text = "تنظیم هشدار"
    $button.Top = 130
    $button.Left = 130
    $button.Width = 120
    $form.Controls.Add($button)

    $button.Add_Click({
        $timeText = $timeInput.Text
        $msg = $msgBox.Text

        if ($timeText -notmatch "^\d{2}:\d{2}$") {
            [System.Windows.Forms.MessageBox]::Show("زمان صحیح وارد نشده است.")
            return
        }

        $now = Get-Date
        $alarmTime = Get-Date "$($now.ToString('yyyy-MM-dd')) $timeText"
        if ($alarmTime -lt $now) {
            $alarmTime = $alarmTime.AddDays(1)
        }

        $seconds = [math]::Round(($alarmTime - $now).TotalSeconds)

        # اجرای هشدار در پس‌زمینه
        Start-Job {
            Start-Sleep -Seconds $using:seconds

            Add-Type -AssemblyName System.Windows.Forms
            $icon = New-Object System.Windows.Forms.NotifyIcon
            $icon.Icon = [System.Drawing.SystemIcons]::Information
            $icon.BalloonTipTitle = "⏰ هشدار"
            $icon.BalloonTipText = $using:msg
            $icon.Visible = $true
            $icon.ShowBalloonTip(10000)

            Start-Sleep -Seconds 10
            $icon.Dispose()
        } | Out-Null

        [System.Windows.Forms.MessageBox]::Show("✅ هشدار تنظیم شد برای ساعت $timeText", "موفقیت")
        $form.Close()
    })

    $form.ShowDialog()
}
function grep-on {
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🔍 جستجوی متن در فایل‌ها"
    $form.Width = 700
    $form.Height = 500
    $form.StartPosition = "CenterScreen"

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Text = "عبارت مورد جستجو:"
    $label1.Top = 10
    $label1.Left = 10
    $form.Controls.Add($label1)

    $searchBox = New-Object System.Windows.Forms.TextBox
    $searchBox.Top = 30
    $searchBox.Left = 10
    $searchBox.Width = 400
    $form.Controls.Add($searchBox)

    $browseBtn = New-Object System.Windows.Forms.Button
    $browseBtn.Text = "انتخاب پوشه"
    $browseBtn.Top = 30
    $browseBtn.Left = 430
    $form.Controls.Add($browseBtn)

    $searchBtn = New-Object System.Windows.Forms.Button
    $searchBtn.Text = "جستجو"
    $searchBtn.Top = 30
    $searchBtn.Left = 550
    $form.Controls.Add($searchBtn)

    $listbox = New-Object System.Windows.Forms.ListBox
    $listbox.Top = 70
    $listbox.Left = 10
    $listbox.Width = 660
    $listbox.Height = 370
    $listbox.Font = 'Consolas,10'
    $form.Controls.Add($listbox)

    $selectedPath = ""

    $browseBtn.Add_Click({
        $fbd = New-Object System.Windows.Forms.FolderBrowserDialog
        if ($fbd.ShowDialog() -eq "OK") {
            $selectedPath = $fbd.SelectedPath
        }
    })

    $searchBtn.Add_Click({
        $listbox.Items.Clear()
        $searchText = $searchBox.Text
        if (-not $selectedPath -or -not $searchText) {
            [System.Windows.Forms.MessageBox]::Show("پوشه و عبارت جستجو را مشخص کنید.")
            return
        }

        $results = @()
        $files = Get-ChildItem -Path $selectedPath -Recurse -Include *.txt,*.ps1,*.log,*.md -File -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            try {
                $lines = Get-Content $file.FullName -ErrorAction Stop
                for ($i = 0; $i -lt $lines.Count; $i++) {
                    if ($lines[$i] -match [regex]::Escape($searchText)) {
                        $entry = "{0} | Line {1}: {2}" -f $file.FullName, ($i + 1), $lines[$i].Trim()
                        $listbox.Items.Add($entry)
                    }
                }
            } catch {
                # فایل غیر متنی یا قابل خواندن نیست
            }
        }

        if ($listbox.Items.Count -eq 0) {
            $listbox.Items.Add("هیچ نتیجه‌ای یافت نشد.")
        }
    })

    $listbox.Add_DoubleClick({
        $selected = $listbox.SelectedItem
        if ($selected -match "^(.*?\.txt|ps1|log|md) \|") {
            $path = $matches[1]
            Invoke-Item $path
        }
    })

    $form.ShowDialog()
}
function notepad-on {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $notePath = "$PSScriptRoot\quicknote.txt"
    if (-not (Test-Path $notePath)) {
        New-Item -Path $notePath -ItemType File | Out-Null
    }

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "📓 دفترچه یادداشت سریع"
    $form.Width = 700
    $form.Height = 500
    $form.StartPosition = "CenterScreen"

    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Multiline = $true
    $textbox.ScrollBars = "Vertical"
    $textbox.Dock = "Fill"
    $textbox.Font = "Consolas, 10"
    $textbox.Text = Get-Content $notePath -Raw
    $form.Controls.Add($textbox)

    $form.Add_FormClosing({
        try {
            $textbox.Text | Set-Content $notePath -Force
        } catch {
            [System.Windows.Forms.MessageBox]::Show("خطا در ذخیره‌سازی یادداشت‌ها.", "خطا")
        }
    })

    $form.ShowDialog()
}
function folderchart-on {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Windows.Forms.DataVisualization

    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "پوشه‌ای برای تحلیل انتخاب کنید"
    if ($dialog.ShowDialog() -ne "OK") { return }

    $path = $dialog.SelectedPath
    $files = Get-ChildItem -Path $path -File -ErrorAction SilentlyContinue
    if ($files.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("هیچ فایل قابل نمایش در این پوشه نیست.")
        return
    }

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "📊 نمودار حجم فایل‌ها"
    $form.Width = 800
    $form.Height = 600
    $form.StartPosition = "CenterScreen"

    $chart = New-Object System.Windows.Forms.DataVisualization.Charting.Chart
    $chart.Width = 760
    $chart.Height = 540
    $chart.Left = 10
    $chart.Top = 10

    $chartArea = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
    $chart.ChartAreas.Add($chartArea)

    $series = New-Object System.Windows.Forms.DataVisualization.Charting.Series
    $series.ChartType = "Pie"
    $series.Font = "Consolas, 9"
    $chart.Series.Add($series)

    foreach ($file in $files) {
        $name = if ($file.Name.Length -gt 30) { $file.Name.Substring(0, 30) + "..." } else { $file.Name }
        $series.Points.AddXY($name, $file.Length / 1MB)
    }

    $chart.Legends.Add("Files")
    $form.Controls.Add($chart)
    $form.ShowDialog()
}
function cleanup-on {
    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🧹 پاکسازی کش و فایل‌های موقت"
    $form.Width = 400
    $form.Height = 250
    $form.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "مواردی که می‌خواهید پاک شود را انتخاب کنید:"
    $label.Top = 20
    $label.Left = 20
    $label.Width = 350
    $form.Controls.Add($label)

    $chkTemp = New-Object System.Windows.Forms.CheckBox
    $chkTemp.Text = "فایل‌های موقت (Temp)"
    $chkTemp.Top = 60
    $chkTemp.Left = 20
    $chkTemp.Checked = $true
    $form.Controls.Add($chkTemp)

    $chkEdge = New-Object System.Windows.Forms.CheckBox
    $chkEdge.Text = "کش مرورگر Edge (اگر نصب باشد)"
    $chkEdge.Top = 90
    $chkEdge.Left = 20
    $form.Controls.Add($chkEdge)

    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = "شروع پاکسازی"
    $btn.Top = 140
    $btn.Left = 130
    $btn.Width = 120
    $form.Controls.Add($btn)

    $btn.Add_Click({
        $totalFreed = 0

        if ($chkTemp.Checked) {
            $tempPaths = @("$env:TEMP", "$env:windir\Temp")
            foreach ($path in $tempPaths) {
                if (Test-Path $path) {
                    $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                    foreach ($file in $files) {
                        try {
                            $size = ($file.Length / 1MB)
                            Remove-Item $file.FullName -Force -Recurse -ErrorAction SilentlyContinue
                            $totalFreed += $size
                        } catch {}
                    }
                }
            }
        }

        if ($chkEdge.Checked) {
            $edgeCache = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"
            if (Test-Path $edgeCache) {
                Get-ChildItem -Path $edgeCache -Recurse -Force -ErrorAction SilentlyContinue |
                    ForEach-Object {
                        try {
                            $size = ($_.Length / 1MB)
                            Remove-Item $_.FullName -Force -Recurse -ErrorAction SilentlyContinue
                            $totalFreed += $size
                        } catch {}
                    }
            }
        }

        [System.Windows.Forms.MessageBox]::Show("✅ پاکسازی انجام شد. حدوداً $([math]::Round($totalFreed, 1)) MB آزاد شد.", "موفقیت")
        $form.Close()
    })

    $form.ShowDialog()
}
function chatgpt-on {
    Add-Type -AssemblyName System.Windows.Forms

    $keyFile = "$PSScriptRoot\apikey.txt"

    if (-not (Test-Path $keyFile)) {
        [System.Windows.Forms.MessageBox]::Show("فایل apikey.txt پیدا نشد. لطفاً توکن را در آن قرار دهید.")
        return
    }

    $apiKey = Get-Content $keyFile -Raw
    if (-not $apiKey.Trim()) {
        [System.Windows.Forms.MessageBox]::Show("فایل apikey.txt خالی است.")
        return
    }

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "🤖 ChatGPT رابط"
    $form.Width = 900
    $form.Height = 600
    $form.StartPosition = "CenterScreen"

    $inputBox = New-Object System.Windows.Forms.TextBox
    $inputBox.Multiline = $true
    $inputBox.ScrollBars = "Vertical"
    $inputBox.Top = 10
    $inputBox.Left = 10
    $inputBox.Width = 860
    $inputBox.Height = 200
    $inputBox.Font = New-Object System.Drawing.Font("Consolas", 30)
    $form.Controls.Add($inputBox)

    $sendBtn = New-Object System.Windows.Forms.Button
    $sendBtn.Text = "ارسال به ChatGPT"
    $sendBtn.Top = 220
    $sendBtn.Left = 370
    $sendBtn.Width = 150
    $sendBtn.Font = New-Object System.Drawing.Font("Tahoma", 14)
    $form.Controls.Add($sendBtn)

    $outputBox = New-Object System.Windows.Forms.TextBox
    $outputBox.Multiline = $true
    $outputBox.ScrollBars = "Vertical"
    $outputBox.ReadOnly = $true
    $outputBox.Top = 270
    $outputBox.Left = 10
    $outputBox.Width = 860
    $outputBox.Height = 270
    $outputBox.Font = New-Object System.Drawing.Font("Consolas", 30)
    $form.Controls.Add($outputBox)

    $sendBtn.Add_Click({
        $prompt = $inputBox.Text
        if (-not $prompt) {
            $outputBox.Text = "لطفاً یک سوال وارد کنید."
            return
        }

        $body = @{
            model = "gpt-4o"
            messages = @(
                @{ role = "user"; content = $prompt }
            )
        } | ConvertTo-Json -Depth 3

        $headers = @{
            "Authorization" = "Bearer $apiKey"
            "Content-Type" = "application/json"
        }

        try {
            $response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" `
                -Method Post -Headers $headers -Body $body

            $reply = $response.choices[0].message.content
            $outputBox.Text = $reply
        } catch {
            $outputBox.Text = "❌ خطا در ارتباط با ChatGPT: $_"
        }
    })

    $form.ShowDialog()
}
function search-on {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Query
    )

    $encoded = [System.Web.HttpUtility]::UrlEncode($Query)
    $url = "https://www.google.com/search?q=$encoded"
    Start-Process $url
}

Set-Alias search search-on
Set-Alias chat chatgpt-on
Set-Alias cleanup cleanup-on
Set-Alias chart folderchart-on
Set-Alias notepad notepad-on
Set-Alias grep grep-on
Set-Alias alarm alarm-on
Set-Alias sandbox sandbox-on
Set-Alias project project-on
Set-Alias secure secure-on
Set-Alias reminder reminder-on
Set-Alias history history-on
Set-Alias task taskm
Set-Alias hacker hacker-on
Set-Alias explorer explor-on
