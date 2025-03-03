### Projet d'Analyse de Données - Spotify Songs

## Description du projet

Ce projet vise à analyser un ensemble de données Spotify contenant 30 000 chansons, disponible sur Kaggle. L'objectif est d'appliquer diverses techniques d'analyse de données vues en cours afin d'explorer les relations entre les caractéristiques des morceaux et leur popularité.

# Objectifs de l'analyse

Nous allons chercher à répondre aux questions suivantes :

Quelle est la qualité des données ? Un pré-traitement est-il nécessaire ?

Comment les différentes variables évoluent-elles en fonction des années et des genres musicaux ?

Quels liens existent entre les variables du dataset ?

Quels facteurs influencent la popularité d'un morceau ?

Les caractéristiques musicales permettent-elles de prédire un genre musical ou d'autres critères pertinents ?

# Données

Source : Kaggle - 30000 Spotify Songs

Nombre d'entrées : 30 000 chansons

Variables principales :

track_id : ID unique de la chanson

track_name : Nom de la chanson

track_artist : Artiste

track_popularity : Score de popularité (0-100)

playlist_genre et playlist_subgenre : Genre et sous-genre de la playlist

danceability, energy, loudness, valence, tempo, duration_ms, etc. : Caractéristiques audio de la chanson

# Méthodologie

Nous appliquerons les techniques suivantes pour explorer et analyser les données :

Pré-traitement des données : Nettoyage, gestion des valeurs manquantes, transformation des variables si nécessaire.

Analyse exploratoire : Visualisation des distributions et des relations entre les variables.

Analyse factorielle et réduction de dimension :

Analyse en Composantes Principales (PCA)

Analyse Discriminante Linéaire (LDA)

Analyse des Correspondances (CA) et Analyse des Correspondances Multiples (MCA)

Analyse Factorielle Multiple (MFA)

# Clustering :

K-means

Clustering hiérarchique (HAC)

Modèles de mélanges gaussiens (GMM)

Modèle Stochastique de Blocs (SBM)

Clustering de graphes

# Autres techniques avancées :

Kernel PCA

Factorisation de Matrice Non Négative (NMF)

Multidimensional Scaling (MDS)

Réduction de dimension non linéaire

# Structure du projet

Projet-Spotify/
|-- data/                      # Fichiers de données bruts et pré-traités
|-- notebooks/
|   |-- Analyse_Exploratoire.ipynb
|   |-- PCA_LDA.ipynb
|   |-- Clustering.ipynb
|   |-- Dimensionality_Reduction.ipynb
|-- src/                       # Scripts Python et R
|-- README.md                  # Documentation du projet

# Technologies utilisées

Python : Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn, Scipy

R : ggplot2, dplyr, FactoMineR, ClustMixType

Jupyter Notebook / R Notebook pour l'analyse interactive

# Auteurs

Projet réalisé dans le cadre du cours d'Analyse de Données 4MA - AD 2024-2025.

Pour toute question ou suggestion, n'hésitez pas à contribuer ou nous contacter !




