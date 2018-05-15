<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:output method="html"/>

<xsl:attribute-set name="font">
	<xsl:attribute name="name">Arial</xsl:attribute>
	<xsl:attribute name="size">11px</xsl:attribute>
	<xsl:attribute name="color">black</xsl:attribute>
</xsl:attribute-set>

<xsl:variable name="refund">
	<b>REFUNDOWANY</b>
</xsl:variable>

<xsl:variable name="nonrefund">
	<b>BEZ REFUNDACJI</b>
</xsl:variable>

<xsl:template match="/">  
	<fo:block quading="start" xsl:use-attribute-sets="font">
	</fo:block>  
	<html>
		<head>
			<meta charset="UTF-8"/>
		</head>
		<body>
			
			<h2>Leki</h2>
			<font size="1">Wykaz leków z dnia
				<xsl:number value="150518"
					grouping-size="2"
					grouping-separator="."/></font>
			<table border="1">
			<tr bgcolor="#3dffe1">
			<th>Nazwa</th>
			<th>Producent</th>
			<th>Substancja czynna</th>
			<th>Cena</th>
			</tr>
			<xsl:apply-templates select="//typ/recepta"/>
			<xsl:apply-templates select="//typ/bezrecepta"/>
			</table>
		</body> 
	</html>
</xsl:template>
  
<xsl:template match="typ/recepta">
    <xsl:for-each select="lek"> 
	<xsl:sort select="nazwa" data-type="text"/>
		<xsl:choose>
			<xsl:when test="@nfz='true'">
	<tr>
        <td><b><xsl:value-of select="nazwa"/> (<xsl:copy-of select="$refund"/>)</b></td>
	<td><xsl:value-of select="producent"/></td>
	<td><xsl:value-of select="substancja_czynna"/></td>
			<xsl:if test="cena>1000">
	<td><b><xsl:value-of select="cena"/></b></td>
			</xsl:if>
			<xsl:if test="not(cena>1001)">
	<td><xsl:value-of select="cena"/></td>
			</xsl:if>
	</tr>
			</xsl:when>
			<xsl:when test="@nfz='false'">
	<tr>
	<td><b><xsl:value-of select="nazwa"/>(<xsl:copy-of select="$nonrefund"/>)</b></td>
	<td><xsl:value-of select="producent"/></td>
	<td><xsl:value-of select="substancja_czynna"/></td>
	<xsl:if test="cena>1000">
	<td><b><xsl:value-of select="cena"/></b></td>
			</xsl:if>
			<xsl:if test="not(cena>1001)">
	<td><xsl:value-of select="cena"/></td>
			</xsl:if>
	</tr>
			</xsl:when>
			<xsl:otherwise>
	<tr>
	<td><xsl:value-of select="nazwa"/></td>
	<td><xsl:value-of select="producent"/></td>
	<td><xsl:value-of select="substancja_czynna"/></td>
	<td><xsl:value-of select="cena"/></td>
	</tr>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:for-each>
    </xsl:template>

    <xsl:template match="typ/bezrecepta">
    <xsl:for-each select="lek"> 
	<xsl:sort select="nazwa" data-type="text"/>
	<tr>
        <td><xsl:value-of select="nazwa"/></td>
	<td><xsl:value-of select="producent"/></td>
	<td><xsl:value-of select="substancja_czynna"/></td>
			<xsl:if test="cena>1000">
	<td><b><xsl:value-of select="cena"/></b></td>
			</xsl:if>
			<xsl:if test="not(cena>1001)">
	<td><xsl:value-of select="cena"/></td>
			</xsl:if>
	</tr>
    </xsl:for-each>

    </xsl:template>


</xsl:stylesheet>
