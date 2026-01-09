# Hello-World-App-CICD

Ez a projekt egy Node.js alkalmazás automatizált infrastruktúra-kezelését és telepítését mutatja be Azure környezetbe, **Terraform** és **GitHub Actions** használatával.

##  Projekt Áttekintés

A projekt egy hibrid CI/CD csatornát (pipeline) valósít meg, ahol a kódellenőrzés automatikus, de az élesítéshez kézi jóváhagyás szükséges.

* **Alkalmazás:** Egyszerű Node.js alapú HTTP szerver.
* **Infrastruktúra:** Azure Web App (Linux) B1-es csomagban.
* **Automatizáció:** GitHub Actions workflow, amely tartalmazza a build, az infrastruktúra provizionálás és a deploy lépéseket.

##  Technológiai Stack

* **Runtime:** Node.js v20 (Build szakasz) és v24-lts (Azure futtatókörnyezet).
* **IaC:** Terraform v1.7.0.
* **Provider:** AzureRM v4.57.0.
* **Platform:** Microsoft Azure.

##  Infrastruktúra (Terraform)

Az erőforrások definíciója a `main.tf` fájlban található:
* **Resource Group:** `cicdtest`.
* **App Service Plan:** Linux alapú, B1 SKU (alapszintű csomag).
* **Web App:** `hello-cicd-app` néven regisztrálva.

### Távoli Állapotkezelés (Backend)
A Terraform állapotfájlja (`terraform.tfstate`) egy központi Azure Storage Accountban tárolódik:
* **Storage Account:** `statestorageacc`.
* **Container:** `tfstate`.

##  CI/CD Workflow Működése

A folyamat három fő szakaszra oszlik, hogy optimális egyensúlyt teremtsen az automatizáció és a kontroll között:

1. **Build:** Minden kódmódosításnál (Push) automatikusan lefut, ellenőrizve a Node.js függőségeket.
2. **Terraform:** Megáll és várakozik. Csak akkor indul el, ha a GitHub felületén jóváhagyod a telepítést (Manual Approval).
3. **Deploy:** A sikeres Terraform futtatás után automatikusan frissíti az alkalmazást az Azure-ban.



##  Szükséges Beállítások

### 1. GitHub Secrets
A pipeline futtatásához az alábbi titkosított változókat kell rögzítened:
* `SUB_ID`: Azure Subscription ID.
* `CLIENT_ID`: Azure Client ID.
* `CLINT_SECRET`: Azure Client Secret.
* `TENANT_ID`: Azure Tenant ID.
* `AZURE_CREDENTIALS2`: JSON alapú Azure hitelesítési adatok.

### 2. Environment Setup
A manuális megállításhoz hozd létre a környezetet:
* **Settings** -> **Environments** -> **New environment** (Név: `production`).
* Kapcsold be a **Required reviewers** opciót és add hozzá magad.

##  Helyi Használat

A projekt tartalmaz egy `.gitignore` fájlt, amely megakadályozza a lokális Terraform fájlok feltöltését. Helyi indításhoz használd az `npm start` parancsot.