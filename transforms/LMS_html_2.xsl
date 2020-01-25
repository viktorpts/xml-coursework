<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/Course">
        <div>
            <h2>
                <xsl:value-of select="Name" />
                <xsl:text> - учебни материали</xsl:text>
            </h2>
            <table border="1">
                <tr>
                    <th>Урок</th>
                    <th>Видео</th>
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
                <td>
                    <xsl:apply-templates select="Resources"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="Resources">
        <ul>
            <xsl:for-each select="Resource[not(@visible='false')]">
                <xsl:sort select="@order" data-type="number" />
                <li>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="URL"/>
                        </xsl:attribute>

                        <xsl:value-of select="Name" />
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

</xsl:stylesheet> 