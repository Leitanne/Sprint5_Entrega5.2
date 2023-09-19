-- Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;

-- Llista totes les columnes de la taula producto.
SELECT * FROM producto;

-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, precio, precio * 1.07 FROM producto;

-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS 'nom de producto', precio AS euros, precio * 1.07 AS dòlars FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre), precio FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre), precio FROM producto;

-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT producto.nombre, UPPER(SUBSTRING(fabricante.nombre, 1, 2)) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio) FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, FLOOR(precio) FROM producto;