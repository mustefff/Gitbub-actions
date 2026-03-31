# Rapport de TP : Automatisation CI/CD avec GitHub Actions 🚀

**Sujet :** Mise en œuvre de l'intégration et du déploiement continus (CI/CD) d'une application Spring Boot vers Docker Hub via GitHub Actions.

---

## 1. Introduction

Ce projet a pour but de démontrer la capacité à automatiser le cycle de vie d'une application moderne. Nous utilisons **GitHub Actions** pour orchestrer les phases de compilation, de test, de mise en conteneur (Dockerisation) et de déploiement.

## 2. Structure du Projet

L'application est un microservice Java basé sur **Spring Boot 3**. Voici l'organisation des fichiers :

```text
github-actions-tp/
├── .github/
│   └── workflows/
│       ├── build.yml         # Pipeline de build simple (JDK 8)
│       └── deploy.yml        # Pipeline complexe Build & Deploy (JDK 17)
├── src/                      # Code source de l'application
├── Dockerfile                # Instructions de création de l'image Docker
├── pom.xml                   # Configuration Maven du projet
└── README.md                 # Ce rapport
```

---

## 3. Configuration des Workflows (CI/CD)

### A. Pipeline de Build Simple (`build.yml`)
Ce workflow se déclenche sur chaque **push** vers les branches `main` et `release`.
- **JDK utilisé :** 8 (Temurin)
- **Action :** Compilation via Maven et publication automatique de l'image Docker via le plugin Spring Boot (`spring-boot:build-image`).

### B. Pipeline Build & Deploy Image (`deploy.yml`)
C'est le pipeline principal divisé en 3 jobs interdépendants :

1.  **Build job :** Compile l'application (JAR) avec **JDK 17** et sauvegarde l'artéfact (`package-final`).
2.  **Analysis job :** Prépare l'étape d'analyse de code (SonarQube).
3.  **Deploy job :** Récupère l'artéfact, construit l'image Docker à partir du `Dockerfile`, et la pousse sur **Docker Hub**.

---

## 4. Étapes de Mise en Œuvre

### Étape 1 : Création du Repository GitHub
1. Créer un nouveau dépôt sur GitHub.
2. Initialiser le dépôt local et lier l'origin :
   ```bash
   git init
   git remote add origin https://github.com/VOTRE_USER/github-actions-tp.git
   ```

### Étape 2 : Configuration des Secrets GitHub
Pour que GitHub puisse pousser l'image sur Docker Hub, vous devez configurer les "Secrets" dans votre dépôt GitHub (**Settings > Secrets and variables > Actions**) :
- `DOCKER_HUB_USER` : Votre nom d'utilisateur Docker Hub.
- `DOCKER_HUB_TOKEN` : Votre Personal Access Token (PAT) Docker Hub.

### Étape 3 : Push du code
Ajouter les fichiers et pousser vers le serveur :
```bash
git add .
git commit -m "Initial commit with GitHub Actions workflows"
git push -u origin main
```

---

## 5. Captures d'Écran et Résultats Attendus

Voici les preuves de fonctionnement à fournir dans ce rapport :

### [CAPTURE_ECRAN_1 : Liste des Workflows]
*   **Emplacement :** Onglet "Actions" sur GitHub.
*   **Justification :** Montre que GitHub a bien détecté les fichiers YAML dans le dossier `.github/workflows`.

### [CAPTURE_ECRAN_2 : Exécution réussie du Workflow "build and deploy image"]
*   **Emplacement :** Détail d'une exécution de workflow.
*   **Justification :** Valide que les 3 jobs (Build, analysis, deploy) sont passés au vert (checkmarks ✅). Cela prouve que le passage d'artéfacts entre jobs a fonctionné.

### [CAPTURE_ECRAN_3 : Logs du Job Deploy]
*   **Emplacement :** Log de l'étape "push image to docker hub".
*   **Justification :** Preuve technique que l'image a bien été transmise aux serveurs de Docker Hub sans erreur d'authentification.

### [CAPTURE_ECRAN_4 : Présence de l'image sur Docker Hub]
*   **Emplacement :** Votre compte Docker Hub (Browser).
*   **Justification :** Résultat final. L'image `ngorseck/thymeleaf-springboot:0.0.2` (ou votre propre nom d'image) est listée avec le tag "latest" ou versionné, prouvant la réussite du cycle CD.

---

## 6. Conclusion
Ce TP démontre la puissance de l'automatisation. Grâce à ces configurations, aucun développeur n'a besoin de construire manuellement l'image Docker ou de se soucier du déploiement ; tout est géré dès que le code est validé sur GitHub.
