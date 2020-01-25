<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/Course">
        <UnitPlan>
            <xsl:for-each select="Units/Unit">
                <Unit>
                    <xsl:attribute name="name">
                        <xsl:value-of select="Name"/>
                    </xsl:attribute>

                    <StartDateTime>
                        <xsl:value-of select="Instance/StartDateTime"/>
                    </StartDateTime>
                    <EndDateTime>
                        <xsl:value-of select="Instance/EndDateTime"/>
                    </EndDateTime>
                </Unit>
            </xsl:for-each>
        </UnitPlan>
    </xsl:template>

</xsl:stylesheet>