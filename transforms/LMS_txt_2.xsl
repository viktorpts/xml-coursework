<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/Course">
        <xsl:text>График на заетостта за обучение </xsl:text>
        <xsl:value-of select="Name"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:for-each select="Units/Unit">
            <xsl:call-template name="FormatDate">
                <xsl:with-param name="DateTime" select="Instance/StartDateTime" />
            </xsl:call-template>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="FormatDate">
        <xsl:param name="DateTime" />
        <xsl:variable name="date">
            <xsl:value-of select="substring-before($DateTime,'T')" />
        </xsl:variable>

        <xsl:variable name="mm">
            <xsl:value-of select="substring($date,6,2)" />
        </xsl:variable>

        <xsl:variable name="dd">
            <xsl:value-of select="substring($date,9,2)" />
        </xsl:variable>

        <xsl:variable name="yyyy">
            <xsl:value-of select="substring($date,1,4)" />
        </xsl:variable>

        <xsl:value-of select="concat($dd,'.', $mm, '.', $yyyy)" />
    </xsl:template>

</xsl:stylesheet>