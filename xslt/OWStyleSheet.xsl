<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:attribute-set name="atrybuty">
    <xsl:attribute name="style">color:green;background-color:white;
                                font-size:20pt
    </xsl:attribute>
    <xsl:attribute name="height">100</xsl:attribute>
    <xsl:attribute name="width">100</xsl:attribute>
  </xsl:attribute-set>

<xsl:key name="supp" match="Hero" use="@Id"/>
  <xsl:variable name="header">
    <tr bgcolor="#405275">
      <th style="text-align:left"></th>
      <th style="text-align:left">Hero</th>
      <th style="text-align:left">Role</th>
      <th style="text-align:left">Pick Rate (This month)</th>
      <th style="text-align:left">Country</th>
    </tr>
</xsl:variable>
  <xsl:variable name="header2">
    <tr bgcolor="#405275">
      <th style="text-align:left"></th>
      <th style="text-align:left">Hero</th>
      <th style="text-align:left">Pick Rate (This month)</th>
    </tr>
</xsl:variable>
<xsl:template match="/">
<html> 
<body>
  <h2>Amount of heroes in the game:     <xsl:value-of select="count(//Hero)"/></h2>
  <h2>English:</h2>
  <xsl:for-each select="Overwatch/Heroes/Hero">
    <xsl:choose > 
      <xsl:when test = "lang('en')" >
      <xsl:value-of select="Quote"/>
      <br></br>
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
    <h2>Unknown:</h2>
  <xsl:for-each select="Overwatch/Heroes/Hero">
    <xsl:choose > 
      <xsl:when test = "lang('un')" >
      <xsl:value-of select="Quote"/>
      <br></br>
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
      <h2>German:</h2>
    <xsl:for-each select="Overwatch/Heroes/Hero">
    <xsl:choose > 
      <xsl:when test = "lang('de')" >
      <xsl:value-of select="Quote"/>
      <br></br>
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
      <h2>Swedish:</h2>
    <xsl:for-each select="Overwatch/Heroes/Hero">
    <xsl:choose > 
      <xsl:when test = "lang('swe')" >
      <xsl:value-of select="Quote"/>
      <br></br>
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
  <h2>Irish:</h2>
    <xsl:for-each select="Overwatch/Heroes/Hero">
    <xsl:choose > 
      <xsl:when test = "lang('ir')" >
      <xsl:value-of select="Quote"/>
      <br></br>
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
  <h2>Heroes with lowest Win Rate(this month)</h2>
                <xsl:for-each select="Overwatch/Heroes/Hero">
                  <xsl:if test="49>Winrate">
          <xsl:call-template name="show_name">
          <xsl:with-param name="Name" select="Name"/>
        </xsl:call-template>
      </xsl:if>
                </xsl:for-each>
                <h2>Total amount of HP of every hero in Overwatch: <xsl:value-of select="sum(Overwatch/Heroes/Hero/Health[text()])"/></h2>
                <h2>Total amount of Armor of every hero in Overwatch: <xsl:value-of select="sum(Overwatch/Heroes/Hero/Armor[text()])"/></h2>
      <h2>Total amount of Shield of every hero in Overwatch: <xsl:value-of select="sum(Overwatch/Heroes/Hero/Shield[text()])"/>  </h2>
      <h2>Average HP per hero <xsl:value-of select="round(sum(Overwatch/Heroes/Hero/Health) div count(//Hero))"/></h2>
    <h2>Overwatch Heroes</h2>
  <table border="1">
  <xsl:copy-of select="$header" />
    <xsl:for-each select="Overwatch/Heroes/Hero">
    <xsl:sort select="Pickrate" order="descending" data-type="number"/>
    <xsl:if test="Pickrate>3">
              <xsl:choose>
          <xsl:when test="Winrate&gt;'50'">
    <tr bgcolor="#f99e1a">
      <td><xsl:number value="position()" format="I" /></td>
      <td><xsl:value-of select="Name"/></td>
      <td><xsl:value-of select="Role"/></td>
      <td align="center"><xsl:value-of select="Pickrate"/>%</td>
      <td> <xsl:value-of select="@Country"/></td>
    </tr>
     </xsl:when>
     <xsl:otherwise>
          <tr>
            <td><xsl:number value="position()" format="I" /></td>
      <td><xsl:value-of select="Name"/></td>
      <td><xsl:value-of select="Role"/></td>
      <td align="center"><xsl:value-of select="Pickrate"/>%</td>
      <td> <xsl:value-of select="@Country"/></td>
    </tr>
              </xsl:otherwise>
        </xsl:choose>
  </xsl:if>
    </xsl:for-each>
  </table>
      <h2>Only Suports</h2>
  <table xsl:use-attribute-sets="atrybuty">
  <xsl:copy-of select="$header2" />
    <xsl:for-each select="key('supp','S')">
    <xsl:sort select="Name"/>
              <xsl:choose>
          <xsl:when test="Winrate&gt;'50'">
    <tr bgcolor="#f99e1a">
      <td><xsl:number value="position()" format="I" /></td>
      <td><xsl:value-of select="Name"/></td>
      <td align="center"><xsl:value-of select="Pickrate"/>%</td>
    </tr>
     </xsl:when>
     <xsl:otherwise>
          <tr>
            <td><xsl:number value="position()" format="I" /></td>
      <td><xsl:value-of select="Name"/></td>
      <td align="center"><xsl:value-of select="Pickrate"/>%</td>
    </tr>
              </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
  </table>
  <h2>Overwatch Hero and their ult</h2>
  <xsl:for-each select="Overwatch/Heroes/Hero">
  <h2><xsl:value-of select="concat(Name,' ', Ultimate)"/></h2>
</xsl:for-each>
</body>
</html>
</xsl:template>
        <xsl:template name = "show_name" >
          <xsl:param name = "Name" /> <!--parameter-->
          <p>Name: <xsl:value-of select = "$Name" /></p>
        </xsl:template>
</xsl:stylesheet>
