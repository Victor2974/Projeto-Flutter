# 🌱 Calculadora de Sustentabilidade

Aplicativo mobile desenvolvido em **Flutter** como atividade prática individual, reunindo calculadoras relacionadas a **energia solar, consumo de energia elétrica e reciclagem**.

O projeto tem como objetivo aplicar conceitos de desenvolvimento mobile com Flutter, trabalhando com navegação entre telas, formulários, validação de dados, cálculos matemáticos e organização de código.

---

## 📱 Funcionalidades

### 🏠 Menu Principal

A tela inicial (`HomeScreen`) permite acessar cada uma das calculadoras disponíveis no aplicativo.

A navegação entre as telas é realizada utilizando:

* `Navigator.push`
* `MaterialPageRoute`

---

### ☀️ Calculadora de Geração de Energia Solar

Calcula uma estimativa da quantidade de energia gerada por um painel solar diariamente.

**Entradas:**

* Área do painel em `m²`
* Horas de sol por dia
* Eficiência do painel em `%`

**Cálculo:**

```text
Energia (kWh/dia) =
Área × Horas de Sol × (Eficiência / 100)
```

---

### 💡 Calculadora de Consumo de Energia

Calcula o consumo diário de um aparelho elétrico e estima seu custo mensal.

**Entradas:**

* Potência do aparelho em Watts
* Horas de utilização por dia
* Preço do kWh em R$

**Consumo diário:**

```text
Consumo Diário (kWh) =
(Potência × Horas de Uso) / 1000
```

**Custo mensal:**

```text
Custo Mensal (R$) =
Consumo Diário × 30 × Preço do kWh
```

---

### ♻️ Calculadora de Meta de Reciclagem

Permite acompanhar o progresso de uma meta mensal de reciclagem.

**Entradas:**

* Quantidade reciclada no mês em kg
* Meta mensal em kg

**Percentual atingido:**

```text
Percentual Atingido (%) =
(Reciclado / Meta) × 100
```

**Quantidade restante:**

```text
Quanto Falta (kg) =
Meta - Reciclado
```
