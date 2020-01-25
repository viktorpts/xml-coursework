<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/Course">
        <div>
            <h2>
                <xsl:value-of select="Name" />
                <xsl:text> - учебен график</xsl:text>
            </h2>
            <table border="1">
                <tr>
                    <th>Урок</th>
                    <th>Дата</th>
                    <th>Начало</th>
                    <th>Край</th>
                </tr>
                <xsl:apply-templates select="Units"/>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="Units">
        <xsl:for-each select="Unit">
            <xsl:sort select="@order" data-type="number" />
            <tr>
                <td>
                    <xsl:value-of select="Name"/>
                </td>
                <xsl:apply-templates select="Instance"/>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="Instance">
        <td>
            <xsl:call-template name="FormatDate">
                <xsl:with-param name="DateTime" select="StartDateTime" />
            </xsl:call-template>
        </td>
        <td>
            <xsl:call-template name="FormatTime">
                <xsl:with-param name="DateTime" select="StartDateTime" />
            </xsl:call-template>
        </td>
        <td>
            <xsl:call-template name="FormatTime">
                <xsl:with-param name="DateTime" select="EndDateTime" />
            </xsl:call-template>
        </td>
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

    <xsl:template name="FormatTime">
        <xsl:param name="DateTime" />
        <xsl:value-of select="substring(substring-after($DateTime,'T'),1,5)" />
    </xsl:template>

</xsl:stylesheet> 