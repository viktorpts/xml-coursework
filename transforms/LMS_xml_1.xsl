<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/Course">
        <Userlist>
            <xsl:for-each select="Students/Student">
                <Email>
                    <xsl:value-of select="Email"/>
                </Email>
            </xsl:for-each>
        </Userlist>
    </xsl:template>

</xsl:stylesheet>