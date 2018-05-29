<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:attribute-set name="atrybuty">
    <xsl:attribute name="style">color:grey;background-color:white;
                                font-size:20pt
    </xsl:attribute>
    <xsl:attribute name="height">100</xsl:attribute>
    <xsl:attribute name="width">100</xsl:attribute>
  </xsl:attribute-set>


  <xsl:variable name="header">
    <tr bgcolor="#660099">
      <th style="text-align:left"></th>
      <th style="text-align:left">Pracownik</th>
      <th style="text-align:left">Nazwisko</th>
      <th style="text-align:left">Wiek</th>
    </tr>
</xsl:variable>
  <xsl:variable name="header2">
    <tr bgcolor="#660099">
      <th style="text-align:left"></th>
      <th style="text-align:left">Artykul</th>
      <th style="text-align:left">Ilosc</th>
	   <th style="text-align:left">Cena</th>
	   <th style="text-align:left">Kraj</th>		
    </tr>
</xsl:variable>
<xsl:template match="/">
<html> 
<body>
 <h2>Pracownicy</h2>
  <table border="1">
  <xsl:copy-of select="$header" />
    <xsl:for-each select="sklep/pracownicy/pracownik">
    <xsl:sort select="wiek" order="ascending" data-type="number"/>
          <tr>
            <td><xsl:number value="position()" format="I" /></td>
      <td><xsl:value-of select="imie"/></td>
      <td><xsl:value-of select="nazwisko"/></td>
      <td align="center"><xsl:value-of select="wiek"/></td>
      <td> <xsl:value-of select="@plec"/></td>
    </tr>
             
  
    </xsl:for-each>
  </table>


  <h2>Ilosc pracownikow     <xsl:value-of select="count(//pracownik)"/></h2>



   
      

<h2>Wiek Pracownikow: <xsl:value-of select="sum(sklep/pracownicy/pracownik/wiek[text()])"/></h2>
<h2>Średnia wieku <xsl:value-of select="round(sum(sklep/pracownicy/pracownik/wiek) div count(//pracownik))"/></h2>
  
<h2>Produkty</h2>
                
  
</body>
</html>
</xsl:template>
        <xsl:template name = "show_name" >
          <xsl:param name = "Name" /> <!--parameter-->
          <p>Name: <xsl:value-of select = "$Name" /></p>
        </xsl:template>
</xsl:stylesheet>
