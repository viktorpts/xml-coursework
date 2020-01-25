<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/Course">
        <div>
            <h2>
                <xsl:text>Видео материали от обучение </xsl:text>
                <xsl:value-of select="Name" />
            </h2>
            <ul>
                <xsl:apply-templates select="Units"/>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="Units">
        <ul>
            <xsl:for-each select="Unit">
                <xsl:sort select="@order" data-type="number" />
                <xsl:call-template name="FormatUnit">
                    <xsl:with-param name="UnitName" select="Name" />
                </xsl:call-template>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template name="FormatUnit">
        <xsl:param name="UnitName" />
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="Resources/Resource[@type='video' and not(@visible='false')]/URL" />
                </xsl:attribute>

                <xsl:value-of select="$UnitName" />
            </a>
        </li>
    </xsl:template>

</xsl:stylesheet> 