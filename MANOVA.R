# MULTIVARIATE ANALYSIS OF VARIANCE

## **LOAD LIBRARIES**

```{r}
library(readxl)
library(tidyverse)
library(ggstatsplot)
library(mvnormtest)
library(onewaytests)
library(gtsummary)
library(flextable)
```

## **ATTACH DATA**

```{r}
df <- datasets::iris
attach(df)
View(df)
```

## **EXPLORATORY ANALYSIS**

```{r}
table1 <- tbl_summary(df, by="Species")
table1
ggbetweenstats(data=df, x="Species", y="Sepal.Length", plot.type="box", type="parametric", pairwise.comparisons=T, pairwise.display="all")
ggbetweenstats(data=df, x="Species", y="Sepal.Width", plot.type="box", type="parametric", pairwise.comparisons=T, pairwise.display="all")
ggbetweenstats(data=df, x="Species", y="Petal.Length", plot.type="box", type="parametric", pairwise.comparisons=T, pairwise.display="all")
ggbetweenstats(data=df, x="Species", y="Petal.Width", plot.type="box", type="parametric", pairwise.comparisons=T, pairwise.display="all")
```

## **MANOVA ASSUMPTIONS**

1.  The dependent variables should be normally distributed within the groups (multivariate normality).

    ```{r}
    qqnorm(Sepal.Length[Species=="setosa"])
    qqnorm(Sepal.Width[Species=="setosa"])
    qqnorm(Petal.Length[Species=="setosa"])
    qqnorm(Petal.Width[Species=="setosa"])
    ```

2.  Homogeneity of variances across the range of predictors.

    ```{r}
    bf.test(data=df, Sepal.Length ~ Species)
    bf.test(data=df, Sepal.Width ~ Species)
    bf.test(data=df, Petal.Length ~ Species)
    bf.test(data=df, Petal.Width ~ Species)
    ```

3.  Linearity between all pairs of dependent variables, all pairs of covariates, and all dependent variable-covariate pairs in each cell

    ```{r}
    ggscatterstats(data=df[Species=="setosa", ], x="Sepal.Length", y="Sepal.Width", type="parametric")
    ggscatterstats(data=df[Species=="setosa", ], x="Petal.Length", y="Petal.Width", type="parametric")
    ```

## MULTIVARIATE ANALYSIS OF VARIANCE

```{r}
man.mod <- manova(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, data=df)
summary(man.mod)
summary.aov(man.mod)
```
