<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/Course">
        <div>
            <h2>
                <xsl:value-of select="Name" />
            </h2>
            <div>
                <h3>Описание</h3>
                <xsl:value-of select="Description" disable-output-escaping="yes" />
            </div>
            <div>
                <h3>Преподаватели</h3>
                <xsl:apply-templates select="Trainers"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="Trainers">
        <xsl:for-each select="Trainer[not(@public='false')]">
            <div>
                <h4>
                    <xsl:value-of select="FirstName"/>
                    <xsl:text></xsl:text>
                    <xsl:value-of select="LastName"/>
                </h4>
                <xsl:apply-templates select="PhotoURL" />
                <xsl:value-of select="Description" disable-output-escaping="yes" />
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="PhotoURL">
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </img>
    </xsl:template>

</xsl:stylesheet> 