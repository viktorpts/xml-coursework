<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/Course">
        <xsl:text>Контакти на потребители в обучение </xsl:text>
        <xsl:value-of select="Name"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:for-each select="Students/Student">
            <xsl:value-of select="Email"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>