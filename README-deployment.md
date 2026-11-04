# Déploiement Docker

```sh
docker build -t pepeflutter-patient ./ap_pepepital_flutter_rdv
docker run --rm -p 8080:80 pepeflutter-patient
```

L'application est compilée pour le chemin `/patient/`. Le reverse proxy doit transmettre ce chemin au conteneur.
