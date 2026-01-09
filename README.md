# Hello-World-App-CICD

Ez a projekt egy Node.js alkalmazás automatizált infrastruktúra-kezelését és telepítését mutatja be Azure környezetbe, **Terraform** és **GitHub Actions** használatával.

##  Projekt Áttekintés

A projekt egy teljes körű CI/CD csatornát valósít meg, amely magában foglalja az infrastruktúra kódként (IaC) történő kezelését és az alkalmazás folyamatos frissítését.

* **Alkalmazás:** Egy egyszerű Node.js HTTP szerver.
* **Infrastruktúra:** Azure Web App (Linux) B1-es csomagban.
* **Automatizáció:** GitHub Actions munkafolyamat a build, provision és deploy lépésekhez.

##  Technológiai Stack

* **Runtime:** Node.js (v20 a build során, v24 az Azure-ban).
* **IaC:** Terraform v1.7.0.
* **Provider:** AzureRM v4.57.0.
* **Platform:** Microsoft Azure.

##  Infrastruktúra (Terraform)

A `main.tf` fájl az alábbi erőforrásokat definiálja:
* **Resource Group:** `cicdtest` (Helyszín: `westeurope`).
* **App Service Plan:** `webapp-asplan` (Linux operációs rendszer, B1 SKU).
* **App Service:** `hello-cicd-app`.
* **Runtime:** Node.js 24-lts verzióra konfigurálva.

### Távoli Állapotkezelés (Backend)
A Terraform állapotfájlja (`terraform.tfstate`) az Azure-ban kerül tárolásra a biztonságos együttműködés érdekében:
* **Storage Account:** `statestorageacc`.
* **Container:** `tfstate`.

##  CI/CD Workflow

A GitHub Actions folyamat (`.github/workflows/ci.yml`) három fő szakaszból áll:

1. **Build:** Letölti a kódot, beállítja a Node.js-t, és telepíti a függőségeket az `npm install` futtatásával.
2. **Terraform:** Inicializálja a távoli backendet, elkészíti a tervet, majd automatikusan jóváhagyja az erőforrások létrehozását.
3. **Deploy:** Bejelentkezik az Azure-ba a megadott hitelesítőkkel, és a `webapps-deploy` segítségével feltölti az alkalmazást a `hello-cicd-app` nevű szolgáltatásra.

##  Szükséges GitHub Secrets

A pipeline futtatásához az alábbi titkosított változók beállítása szükséges a repository-ban:
* `SUB_ID`: Azure előfizetés azonosító.
* `CLIENT_ID`: Azure Client ID.
* `CLINT_SECRET`: Azure Client Secret.
* `TENANT_ID`: Azure Tenant ID.
* `AZURE_CREDENTIALS2`: JSON formátumú Azure hitelesítési adatok.

## 📖 Helyi Futtatás

A projekt tartalmaz egy `.gitignore` fájlt, amely megakadályozza a lokális Terraform fájlok verziókövetését. Az alkalmazás helyileg az `npm start` paranccsal indítható a 3000-es porton.