<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/6wj0hh6.jpg" alt="Project logo"></a>
</p>

<h3 align="center">Set Default Homepage Policy for Edge & Chrome</h3>

<div align="center">

  [![Status](https://img.shields.io/badge/status-active-success.svg)]() 
  [![GitHub Issues](https://img.shields.io/github/issues/rubenmunoz/Set-Homepage-Policy.svg)](https://github.com/rubenmunoz/Set-Homepage-Policy/issues)
  [![GitHub Pull Requests](https://img.shields.io/github/issues-pr/rubenmunoz/Set-Homepage-Policy.svg)](https://github.com/rubenmunoz/Set-Homepage-Policy/pulls)
  [![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> 
PowerShell script to enforce a default homepage for Microsoft Edge and Google Chrome using machine-wide registry policies.  
Designed for automation platforms like NinjaOne.
<br> 
</p>

## 📝 Table of Contents
- [About](#about)
- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)
- [TODO](../TODO.md)
- [Contributing](../CONTRIBUTING.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

---

## 🧐 About <a name = "about"></a>
This project enforces a consistent homepage across all devices within an organization by using registry-based browser policies.  
It ensures that both Microsoft Edge and Google Chrome open to a specified homepage on startup and display a Home button that leads to the same page.  

The script uses Windows PowerShell to modify **HKLM** registry keys under the **Policies** path, which applies settings to all users on the machine. When deployed via an automation tool such as **NinjaOne**, it runs as `SYSTEM` and guarantees persistence across logins and reboots.

---

## 🏁 Getting Started <a name = "getting_started"></a>

These steps will help you set up and deploy the script in a management environment.

### Prerequisites
- Windows 10 or later  
- PowerShell 5.1 or newer  
- Administrator or SYSTEM permissions (for HKLM access)  
- (Optional) NinjaOne or another RMM tool for automation

### Installing
Clone or download the PowerShell script to your system or automation repository.

```
git clone https://github.com/rubenmunoz/Set-Homepage-Policy.git
```

Open **NinjaOne → Automation → Components → Add Script**, and paste the script contents.

Set the script variable `Homepage` to your organization’s homepage URL (e.g., `https://www.georgiastate.edu`).

---

## 🔧 Running the tests <a name = "tests"></a>
Currently, this project doesn’t include formal unit tests.  
You can manually verify correct application by checking browser policy pages:

### Edge
```
edge://policy
```
### Chrome
```
chrome://policy
```

You should see:
- `HomepageLocation`
- `RestoreOnStartup`
- `RestoreOnStartupURLs`

All showing “Loaded” with your configured URL.

---

## 🎈 Usage <a name="usage"></a>

To apply the policy:
1. Deploy the PowerShell script through NinjaOne or run it locally as an Administrator.
2. The script writes registry policies to:
   - `HKLM\SOFTWARE\Policies\Microsoft\Edge`
   - `HKLM\SOFTWARE\Policies\Google\Chrome`
3. On next launch, both browsers will open to the homepage and display a managed “Home” button.

Example local execution:
```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Set-Homepage.ps1 -Homepage "https://intranet.company.com"
```

---

## 🚀 Deployment <a name = "deployment"></a>

1. In **NinjaOne**, go to **Policies → Add Component**.  
2. Paste the script and configure:
   - **Run As:** System  
   - **Shell:** PowerShell (64-bit)  
   - **Triggers:** At Startup + Once ASAP  
3. Save and attach it to your workstation/server policies.  
4. Once deployed, the homepage setting will be enforced automatically for all users.

To revert, remove the registry keys under the same `Policies` paths.

---

## ⛏️ Built Using <a name = "built_using"></a>
- [PowerShell](https://learn.microsoft.com/en-us/powershell/) – Automation scripting
- [Windows Registry](https://learn.microsoft.com/en-us/windows/win32/sysinfo/registry) – Policy storage
- [NinjaOne](https://www.ninjaone.com/) – RMM platform for deployment

---

## ✍️ Authors <a name = "authors"></a>
- [@RubenMunoz](https://github.com/rubenmunoz) – Developer & Maintainer  
- Template based on [The Documentation Compendium](https://github.com/kylelobo/The-Documentation-Compendium)

---

## 🎉 Acknowledgements <a name = "acknowledgement"></a>
- Thanks to **Microsoft** and **Google** for providing detailed documentation on policy registry paths.  
- Inspired by enterprise IT automation practices.  
- Tested and validated via **NinjaOne Policy Automation**.
