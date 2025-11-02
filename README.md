# On solving the viscous Burgers' equation

This repository contains several MATLAB scripts and one Jupyter notebook related to numerical solutions of the viscous Burgers' equation, as well as a comparison with PINN/MLP approaches. Below is a description of each file.

---

## Numerical schemes

### **`eksplicitna.m`**
Implementation of an explicit numerical scheme for solving the viscous Burgers' equation (central discretization for the diffusion term).

### **`poluimplicitna.m`**
Implementation of a semi-implicit scheme: nonlinear convective term treated explicitly, diffusion term treated implicitly.

### **`generisanje.m`**
Script for generating datasets from numerical solutions for MLP training.

---

## Test cases (numerical scheme comparison)

### **`veliki_skok.m`**
Large jump in the initial condition.  
Tests how each scheme handles strong discontinuities (shock-like behavior).

### **`velike_oscilacije.m`**
Initial condition with large oscillations.  
Evaluates damping of high-frequency modes and numerical stability.

### **`veci_pocetni.m`**
Sequence of cases with increasingly large initial conditions.  
Analyzes nonlinear growth and stability under stronger convection.

### **`superpozicija.m`**
Initial condition as a superposition of Fourier modes.  
Used to test how well the scheme reproduces modal interactions and diffusion effects.

---

## PINN / MLP approaches

### **`pinn_burg.ipynb`**
Jupyter notebook implementing:
- a Physics-Informed Neural Network (PINN)  
- a classical MLP trained on numerical data  
