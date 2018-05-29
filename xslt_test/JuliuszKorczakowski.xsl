<?xml version="1.0"?>
<!--Juliusz Korczakowski!-->
<!--grupa A!-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:output method="html"/>

<xsl:attribute-set name="font">
	<xsl:attribute name="name">Arial</xsl:attribute>
	<xsl:attribute name="size">11px</xsl:attribute>
	<xsl:attribute name="color">black</xsl:attribute>
</xsl:attribute-set>

<xsl:variable name="kobieta">
	<b>(kobieta)</b>
</xsl:variable>

<xsl:variable name="mezczyzna">
	<b>(mężczyzna)</b>
</xsl:variable>

<xsl:template match="/">  
	<fo:block quading="start" xsl:use-attribute-sets="font">
	</fo:block>  
	<html>
		<head>
			<meta charset="UTF-8"/>
		</head>
		<body>
			
			<h2>Pracownicy</h2>
			<font size="1">Wykaz pracowników z dnia
				<xsl:number value="290518"
					grouping-size="2"
					grouping-separator="."/></font>
			<table border="1">
			<tr bgcolor="#3dffe1">
			<th>Imię</th>
			<th>Nazwisko</th>
			<th>Wiek</th>
			</tr>
            <xsl:apply-templates select="//pracownicy"/>
</table>
            <table border="1">
			<tr bgcolor="#3dffe1">
			<th>Nazwa</th>
			<th>Ilość</th>
			<th>Waluta</th>
			<th>Kraj</th>
			</tr>

        	<xsl:apply-templates select="//artykuly/dzial"/>

			
			</table>
		</body> 
	</html>
</xsl:template>


<xsl:template match="artykuly/dzial">
<xsl:for-each select="proszek">
<xsl:sort select="ilosc" data-type="text"/>
<tr>
	<td>Proszek</td>
	<td><xsl:value-of select="ilosc"/></td>
	<td><xsl:value-of select="cena"/></td>
	<td><xsl:value-of select="kraj"/></td>
</tr>
</xsl:for-each>
<xsl:for-each select="ludwik">
<tr>
<td>Ludwik</td>
	<td><xsl:value-of select="ilosc"/></td>
	<td><xsl:value-of select="cena"/></td>
	<td><xsl:value-of select="kraj"/></td>
</tr>
</xsl:for-each>
<xsl:for-each select="worki">
<tr>
<td>Worki</td>
	<td><xsl:value-of select="ilosc"/></td>
	<td><xsl:value-of select="cena"/></td>
	<td><xsl:value-of select="kraj"/></td>
</tr>
</xsl:for-each>
<xsl:for-each select="szczoteczka">
<tr>
<td>Szczoteczka</td>
	<td><xsl:value-of select="ilosc"/></td>
	<td><xsl:value-of select="cena"/></td>
	<td><xsl:value-of select="kraj"/></td>
</tr>
</xsl:for-each>


</xsl:template>



<xsl:template match="pracownicy">
    <xsl:for-each select="pracownik"> 
	<xsl:sort select="imie" data-type="text"/>
		<xsl:choose>
			<xsl:when test="@plec='m'">
	<tr>
        <td><b><xsl:value-of select="imie"/> (<xsl:copy-of select="$kobieta"/>)</b></td>
	<td><xsl:value-of select="nazwisko"/></td>
			<xsl:if test="wiek>25">
	<td><b><xsl:value-of select="wiek"/></b></td>
			</xsl:if>
			<xsl:if test="not(wiek>26)">
	<td><xsl:value-of select="wiek"/></td>
			</xsl:if>
	</tr>
			</xsl:when>
			<xsl:when test="@plec='m'">
	<tr>
	<td><b><xsl:value-of select="imie"/>(<xsl:copy-of select="$mezczyzna"/>)</b></td>
	<td><xsl:value-of select="nazwisko"/></td>
	<xsl:if test="wiek>25">
	<td><b><xsl:value-of select="wiek"/></b></td>
			</xsl:if>
			<xsl:if test="not(wiek>26)">
	<td><xsl:value-of select="wiek"/></td>
			</xsl:if>
	</tr>
			</xsl:when>
			<xsl:otherwise>
	<tr>
	<td><xsl:value-of select="imie"/></td>
	<td><xsl:value-of select="nazwisko"/></td>
	<td><xsl:value-of select="wiek"/></td>
	</tr>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:for-each>
    </xsl:template>
    </xsl:stylesheet>