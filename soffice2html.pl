#!/usr/bin/perl
#
#  Copyright (c) 2003 Steve Slaven, All Rights Reserved.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of
#  the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
#  MA 02111-1307 USA
#

use strict;
use Getopt::Std;
use Cwd;

my %o;
$o{ c } = "convert";
$o{ x } = "xsltproc";
getopts( 'hqwpvi:s:t:e:c:x:TB', \%o );

my $ext = $o{ p } ? 'png' : 'jpg';

my @params;
push( @params, '--param', 'image-prefix', "'$o{ i }'" ) if $o{ i };
push( @params, '--param', 'style-prefix', "'$o{ s }'" ) if $o{ s };
push( @params, '--param', 'toc-class', "'$o{ t }'" ) if $o{ t };
push( @params, '--param', 'image-extension', "'$ext'" );
push( @params, '--param', 'full-wrapper', "'yes'" ) if $o{ w };
push( @params, '--param', 'toc-section', "'no'" ) if $o{ B };
push( @params, '--param', 'content-section', "'no'" ) if $o{ T };

my $dest = cwd();

my $input = shift() || usage();
$input = cwd() . "/$input" unless $input =~ m!^/!;
dprint( "Input file is '$input'" );

# First setup temp space
my $bin = $0;
$bin =~ s!^.*/!!;

my $tmp = "/tmp/$bin-$$";
dprint( "Temp dir id $tmp" );
mkdir $tmp || dieup( "Unable to create temp dir '$tmp'" );
chdir( $tmp );

# Now unzip original file
dprint( "Unzipping archive" );
system( "unzip", "-o", "-q", $input );

# Try and determine encoding type
open( IN, "content.xml" );
my $encoding = <IN>;
close( IN );
( $encoding ) = $encoding =~ /encoding="(.*)"/i;
$o{ e } ||= $encoding;
push( @params, "--param", "output-encoding", "'$o{e}'" );
dprint( "Output encoding: $o{e}" );

# Strip "smart" quotes
open( IN, "content.xml" );
my $fix = join( "", <IN> );
close( IN );

my %replace = (
	"\xE2\x80\x9C" => '&quot;',
	"\xE2\x80\x9D" => '&quot;',
	"\xE2\x80\x98" => "'",
	"\xE2\x80\x99" => "'"
);

for( keys( %replace ) ) {
	$fix =~ s/$_/$replace{$_}/gs;
}

open( OUT, ">content.xml" );
print OUT $fix;
close( OUT );

# Create html base doc
dprint( "Applying stylesheet" );
open( XSL, ">convert.xslt" );
print XSL <DATA>;
close( XSL );
# I think this is silly, people should just make a shell wrapper
if( $o{ w } ) { open( OUT, ">content.html" ); print OUT "<html><body>"; close( OUT ); }
system( $o{ x }, @params, "--novalid", "--output", "content.html", "convert.xslt", "content.xml" );
if( $o{ w } ) { open( OUT, ">>content.html" ); print OUT "</body></html>"; close( OUT ); }

# Create jpg images
dprint( "Converting images" );
mkdir "image" || dieup( "Can't make image dir" );
for( glob( "Pictures/*" ) ) {
    next unless -f $_;
    my $output = $_;
    $output =~ s!^Pictures!image!;
    $output =~ s!\..*?$!.$ext!;
    system( $o{ c }, $_, $output );
}

# Delete pre-existing
dprint( "Deleting files" );
unlink( "$dest/content.html" ) if -f "$dest/content.html";
unlink( glob( "$dest/image/*" ) ) if -d "$dest/image";
rmdir( "$dest/image" ) if -d "$dest/image";

# Move to dest, use system commands because it handles moving across filesystems
dprint( "Moving files" );
system( "mv", "image", $dest );
system( "mv", "content.html", $dest );

# Done!
cleanup();

sub dieup {
    cleanup();
    die( shift() );
}

sub cleanup {
    dprint( "Deleting temp dir" );
    system( "rm", "-rf", $tmp ) if -d $tmp;
}

sub dprint {
    print shift() . "\n" if $o{ v };
}

sub usage {
    die( qq{Convert StarOffice to HTML v0.76
Author: Steve Slaven - http://hoopajoo.net
Usage: $0 [-hqvwp] [-e encoding] [-i imagedir]
	  [-s style_base] [-t toc_class] FILE

-h	This help
-q	Quiet mode (deprecated, on by default)
-v	Verbose mode (used to be default)
-i	Image directory (default image/)
-s	CSS base style that all content is wrapped in (default soffice)
-t	Class name to build TOC from (default none)
-e	Output encoding, it will now try to autodetect it but you can
	override it with this switch (e.g. -e iso-8859-2)
-p	Output png files instead of jpg files
-w	Wrap output with <html></html>
-c	Path to "convert" binary
-x	Path to "xsltproc" binary
-T	Generate TOC only
-B	Generate body only

Converts the FILE to content.html with no standard body wrapper so it can
be inserted in to existing templates.  All images are converted to JPG
and all styles are converted to CSS included in the content.html.  Requires
ImageMagick's 'convert', and 'xsltproc' from libxml.

If you use -i, it will be reflected in the html file but you will need to
rename the image directory, mostly because I felt that it was unsafe in
the case that -i was "." and could delete stuff it shouldn't, since the
image/ directory is deleted when doing the conversion.
} );
}

# Put style sheet here
__DATA__
<?xml version="1.0"?>

<!-- soffice2html.xsl v0.76 -->
<!-- Converts the content.xml from an openoffice.org doc to html -->
<!-- Author: Steve Slaven - http://hoopajoo.net -->
<!-- Several styles contributed by Adrend van Beelen jr (http://www.liacs.nl/~dvbeelen) -->
<!-- Requires something external to handle image conversion -->
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xmlns:office="http://openoffice.org/2000/office"
      xmlns:style="http://openoffice.org/2000/style"
      xmlns:text="http://openoffice.org/2000/text"
      xmlns:table="http://openoffice.org/2000/table"
      xmlns:draw="http://openoffice.org/2000/drawing"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      xmlns:number="http://openoffice.org/2000/datastyle"
      xmlns:svg="http://www.w3.org/2000/svg"
      xmlns:chart="http://openoffice.org/2000/chart"
      xmlns:dr3d="http://openoffice.org/2000/dr3d"
      xmlns:math="http://www.w3.org/1998/Math/MathML"
      xmlns:form="http://openoffice.org/2000/form"
      xmlns:script="http://openoffice.org/2000/script"
      xmlns:saxon="http://icl.com/saxon"
      extension-element-prefixes="saxon" >

<xsl:param name="image-prefix" select="'image'"/>
<xsl:param name="style-prefix" select="'soffice'"/>

<xsl:param name="define-base-style" select="'yes'"/>

<!-- these are really less helpful than they seem, since according to the spec an
     xslt processor is *not* required to use the same id()s every time, so in the
     future using 2 runs to make the toc and content sections could produce different
     id()s between the hrefs and names -->
<xsl:param name="toc-section" select="'yes'"/>
<xsl:param name="style-section" select="'yes'"/>
<xsl:param name="content-section" select="'yes'"/>

<xsl:param name="image-extension" select="'jpg'"/>
<xsl:param name="output-encoding" select="'utf-8'"/>

<!-- sx2ml also uses a higher default dpi, using 96 dpi makes everything feel "small" -->
<xsl:param name="dpi" select="'105'"/>

<!-- I don't like this feature, people should just make a wrapper, it'd be cleaner
	As it is with this, you have zero control over the html heading info -->
<xsl:param name="full-wrapper" select="'no'"/>

<xsl:output method="html" encoding="$output-encoding"/>

<!-- Make general document, this is the master format for the overall doc struct -->
<xsl:template match="/">
<xsl:choose>

<xsl:when test="$full-wrapper = 'yes'">
<html>
<body>
<xsl:apply-templates select="/" mode="actual-root"/>
</body>
</html>
</xsl:when>

<xsl:otherwise>
<xsl:apply-templates select="/" mode="actual-root"/>
</xsl:otherwise>

</xsl:choose>

</xsl:template>

<xsl:template match="/" mode="actual-root">

<xsl:if test="$style-section = 'yes'">
<style type="text/css">
<xsl:if test="$define-base-style = 'yes'">
.<xsl:value-of select="$style-prefix"/> {

}
</xsl:if>
.<xsl:value-of select="$style-prefix"/> ul {
  padding-left: 2ex
}
.<xsl:value-of select="$style-prefix"/> ol {
  padding-left: 2ex
}
<xsl:apply-templates select="//style:style" mode="stylesheet"/>
</style>
</xsl:if>
<xsl:apply-templates match="//office:body"/>
</xsl:template>

<!-- Generates the style sheet infos -->
<xsl:template match="style:style" mode="stylesheet">
<xsl:call-template name="generate-style">
 <xsl:with-param name="stylename" select="@style:name"/></xsl:call-template>
<xsl:call-template name="generate-style">
 <xsl:with-param name="stylename" select="@style:list-style-name"/></xsl:call-template>
</xsl:template>

<!-- this does some basic CSS passthrough and conversion -->
<xsl:template match="style:properties" mode="stylesheet">
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@style:font-name'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="attrib" select="'@style:horizontal-pos'"/>
  <xsl:with-param name="css" select="'text-align'"/>
  <xsl:with-param name="after" select="'-'"/>
  <xsl:with-param name="xlate-align" select="'yes'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="attrib" select="'@fo:text-align'"/>
  <xsl:with-param name="xlate-align" select="'yes'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:margin-left'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:margin-top'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:margin-right'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:margin-bottom'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:text-indent'"/></xsl:call-template>
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@fo:font-size'"/></xsl:call-template>
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@fo:line-height'"/></xsl:call-template>
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@fo:font-weight'"/></xsl:call-template>
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@fo:font-style'"/></xsl:call-template>
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@fo:color'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:padding'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:padding-left'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:padding-top'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:padding-right'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:padding-bottom'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:border'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:border-left'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:border-top'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:border-right'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@fo:border-bottom'"/></xsl:call-template>
<xsl:call-template name="pass-css"><xsl:with-param name="attrib" select="'@style:text-background-color'"/>
<xsl:with-param name="css" select="'background'"/></xsl:call-template>
<xsl:call-template name="pass-css">
  <xsl:with-param name="xlate-px" select="'yes'"/>
  <xsl:with-param name="attrib" select="'@style:width'"/></xsl:call-template>
</xsl:template>

<!-- special case list handling -->
<xsl:template match="text:list-style" mode="stylesheet">
<xsl:call-template name="generate-style">
 <xsl:with-param name="stylename" select="@style:name"/></xsl:call-template>
<xsl:call-template name="generate-style">
 <xsl:with-param name="stylename" select="@style:list-style-name"/></xsl:call-template>
</xsl:template>

<xsl:template match="text:list-level-style-number" mode="stylesheet">
<xsl:choose>
	<xsl:when test="@style:number-format='A'">list-style-type: upper-alpha;
</xsl:when>
	<xsl:when test="@style:number-format='a'">list-style-type: lower-alpha;
</xsl:when>
	<xsl:when test="@style:number-format='1'">list-style-type: decimal;
</xsl:when>
	<xsl:when test="@style:number-format='I'">list-style-type: upper-roman;
</xsl:when>
	<xsl:when test="@style:number-format='i'">list-style-type: lower-roman; 
</xsl:when>
</xsl:choose>
</xsl:template>

<xsl:template name="pass-css">
<xsl:param name="attrib"/>
<xsl:param name="css" select="substring-after($attrib,':')"/>

<xsl:param name="before"/>
<xsl:param name="after"/>
<xsl:param name="output" select="saxon:evaluate($attrib)"/>

<xsl:param name="xlate-align"/>
<xsl:param name="xlate-px"/>

<xsl:variable name="modified-output">
<xsl:choose>
 <xsl:when test="$before">
  <xsl:value-of select="substring-before($output,$before)"/>
 </xsl:when>
 <xsl:when test="$after">
  <xsl:value-of select="substring-after($output,$after)"/>
 </xsl:when>
 <xsl:otherwise>
  <xsl:value-of select="$output"/>
 </xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="final-output">
<xsl:choose>

 <xsl:when test="$xlate-align">
  <xsl:choose>
   <xsl:when test="$modified-output = 'end'">
    <xsl:value-of select="'right'"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$modified-output"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:when>

 <xsl:when test="$xlate-px">
   <xsl:variable name="left">
     <xsl:value-of select="substring-before($modified-output,' ')"/>
   </xsl:variable>

   <xsl:variable name="right">
     <xsl:value-of select="substring-after($modified-output,' ')"/>
   </xsl:variable>

   <xsl:choose>
     <xsl:when test="$left = ''">
       <!-- the xlate item was not like 0.1in black or something, it was just 1 field -->
       <xsl:call-template name="pixels">
         <xsl:with-param name="value" select="$modified-output"/>
       </xsl:call-template>
     </xsl:when>

     <xsl:otherwise>
       <!-- this will just convert the first item in a list of items, table cells usually have
            the size and color in the attribute so we need to split it out -->
       <xsl:variable name="fixed-left">
         <xsl:call-template name="pixels">
           <xsl:with-param name="value" select="$left"/>
         </xsl:call-template>
       </xsl:variable>
       <xsl:value-of select="concat($fixed-left,' ',$right)"/>
     </xsl:otherwise>
   </xsl:choose>
 </xsl:when>

 <xsl:otherwise>
  <xsl:value-of select="$modified-output"/>
 </xsl:otherwise>

</xsl:choose>
</xsl:variable>

<!-- eval even though we have a value cause it might get mangled and we're testing the eval value, not
     the passed value -->
<xsl:if test="saxon:evaluate($attrib)">  <xsl:value-of select="$css"/>: <xsl:value-of select="$final-output"/> ;
</xsl:if>
</xsl:template>

<!-- Basically a wrapper to the recursive code to make a TOC that adds the OL around it -->
<xsl:template name="generate-toc">
<xsl:param name="nodes" select="//text:h[@text:level=1]"/>
<ol><xsl:apply-templates select="$nodes" mode="toc"/></ol>
</xsl:template>

<!-- Generate toc nodes if right style type, strip off the leading style type then call itself again -->
<xsl:template match="//text:h" mode="toc">
 <li><a href="#{generate-id()}"><xsl:value-of select="."/></a></li>

 <xsl:variable name="level" select="@text:level"/>
 <!--
 <xsl:variable name="position" select="position()"/>
 <xsl:variable name="next-position" select="//text:h[@text:level=$level][$position + 1]"/> -->
 <xsl:variable name="me" select="."/>

 <!-- Slice of the next level, get all peer nodes between this level and the next sibling on same level -->
 <!-- <xsl:variable name="wouldbe" select="//text:h[@text:level=($level+1) and
  preceding-sibling::text:h[@text:level=$level]=$me]"/> -->
 <xsl:variable name="wouldbe" select="//text:h[@text:level=($level+1) and preceding-sibling::text:h[@text:level=$level and position()=1]=$me]"/>
 <!-- <xsl:variable name="wouldbe" select="//text:h[@text:level=($level+1)]"/> -->
<xsl:if test="$wouldbe">
 <xsl:call-template name="generate-toc">
      <xsl:with-param name="nodes" select="$wouldbe"/>
     </xsl:call-template>
</xsl:if>

</xsl:template>

<!-- Main html handling -->
<xsl:template match="office:body">
<div><xsl:attribute name="class"><xsl:value-of select="$style-prefix"/></xsl:attribute>
<xsl:if test="$toc-section = 'yes'"><xsl:call-template name="generate-toc"/>
</xsl:if><xsl:if test="$content-section = 'yes'">
<xsl:apply-templates/></xsl:if>
</div>
</xsl:template>

<xsl:template match="draw:caption">
<!-- eat these, we can't do floating boxes (yet) -->
</xsl:template>

<xsl:template match="text:p">
<p><xsl:call-template name="insert-style"/>
<xsl:apply-templates/>
<!-- we add a trailing nbsp so that for table cells that are empty the borders still render -->
<xsl:call-template name="nbsp"/></p>
</xsl:template>

<xsl:template match="text:line-break">
<br/>
</xsl:template>

<xsl:template match="text:a">
<a><xsl:attribute name="href"><xsl:value-of select="@xlink:href"/></xsl:attribute><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="text:span">
<span><xsl:call-template name="insert-style"/><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="text:tab-stop">
<span style="padding: 2ex"></span>
</xsl:template>

<!-- space -->
<xsl:template match="text:s">
<xsl:call-template name="nbsp"/>
</xsl:template>

<!-- text headers, accept th first 6 levels for H style conversion, or use a div because it's
	not an inline element (at least not typically) -->
<xsl:template match="text:h">
<xsl:choose>
	<xsl:when test="@text:level=1"><h1><xsl:call-template name="insert-style"/><xsl:apply-templates/></h1></xsl:when>
	<xsl:when test="@text:level=2"><h2><xsl:call-template name="insert-style"/><xsl:apply-templates/></h2></xsl:when>
	<xsl:when test="@text:level=3"><h3><xsl:call-template name="insert-style"/><xsl:apply-templates/></h3></xsl:when>
	<xsl:when test="@text:level=4"><h4><xsl:call-template name="insert-style"/><xsl:apply-templates/></h4></xsl:when>
	<xsl:when test="@text:level=5"><h5><xsl:call-template name="insert-style"/><xsl:apply-templates/></h5></xsl:when>
	<xsl:when test="@text:level=6"><h6><xsl:call-template name="insert-style"/><xsl:apply-templates/></h6></xsl:when>

	<xsl:otherwise><div><xsl:call-template name="insert-style"/><xsl:apply-templates/></div></xsl:otherwise>
</xsl:choose>
<a name="{generate-id()}"/>
</xsl:template>

<!-- list handling -->
<xsl:template match="text:ordered-list">
<ol><xsl:call-template name="insert-style"/><xsl:apply-templates/></ol>
</xsl:template>

<xsl:template match="text:unordered-list">
<ul><xsl:call-template name="insert-style"/><xsl:apply-templates/></ul>
</xsl:template>

<xsl:template match="text:list-item">
<li><xsl:call-template name="insert-style"/><xsl:apply-templates/></li>
</xsl:template>

<!-- This presumes some external script will handle image conversion -->
<xsl:template match="draw:image">

<!-- handle internal/external href, if the hrefs are external they will have the
     prefix prepended to them and the extension will be changed to .jpg, it's up
     to some kind of wrapper to convert the images there -->
<xsl:variable name="final-uri">
  <xsl:choose>
  <xsl:when test="substring(@xlink:href,1,1)='#'">
    <xsl:value-of select="$image-prefix"/>/<xsl:value-of select="substring-before(substring(@xlink:href,11),'.')"/>.<xsl:value-of select="$image-extension"/>
  </xsl:when>
  <xsl:otherwise>
    <!-- this is an external href, the image is not embedded.
         We leave it intact in case the user wants to handle this case properly -->
    <xsl:value-of select="substring-before(@xlink:href,'.')"/>.<xsl:value-of select="$image-extension"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<span><xsl:call-template name="insert-style"/>
<img><xsl:attribute name="src"><xsl:value-of select="$final-uri"/></xsl:attribute>
<!-- I don't like the line breaking here in the output, but oh well -->
<xsl:attribute name="style">
   width: <xsl:call-template name="pixels"> 
     <xsl:with-param name="value" select="@svg:width"/> 
   </xsl:call-template> ;
   height: <xsl:call-template name="pixels"> 
     <xsl:with-param name="value" select="@svg:height"/> 
   </xsl:call-template> 
</xsl:attribute>
</img></span><br/>
</xsl:template>

<!-- text box becomes a div -->
<xsl:template match="draw:text-box">
<div><xsl:call-template name="insert-style"/><xsl:apply-templates/></div>
</xsl:template>

<!-- table handling -->
<xsl:template match="table:table">
<!-- eliminate cellspacing since there isn't anything that seems to override it in the styles -->
<table cellspacing="0"><xsl:call-template name="insert-style"/><xsl:apply-templates/></table>
</xsl:template>

<xsl:template match="table:table-header-rows">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="table:table-row">
<tr><xsl:call-template name="insert-style"/><xsl:apply-templates/></tr>
</xsl:template>

<xsl:template match="table:table-cell">
<td><xsl:call-template name="insert-style"/><xsl:apply-templates/></td>
</xsl:template>

<!-- call by name stuff -->
<xsl:template name="insert-style">
 <xsl:call-template name="insert-style-work">
  <xsl:with-param name="stylename" select="@text:style-name"/>
 </xsl:call-template>

 <xsl:call-template name="insert-style-work">
  <xsl:with-param name="stylename" select="@draw:style-name"/>
 </xsl:call-template>

 <xsl:call-template name="insert-style-work">
  <xsl:with-param name="stylename" select="@table:style-name"/>
 </xsl:call-template>
</xsl:template>

<xsl:template name="insert-style-work">
 <xsl:param name="stylename"/>
 <xsl:param name="final-stylename" select="translate($stylename,'. ','_')"/>

 <xsl:if test="$stylename != ''">
  <xsl:attribute name="class">
    <xsl:value-of select="$style-prefix"/>_<xsl:value-of select="$final-stylename"/></xsl:attribute>
 </xsl:if>
</xsl:template>

<xsl:template name="generate-style">
 <xsl:param name="stylename"/>
 <!-- cleanse name -->
 <xsl:param name="final-stylename" select="translate($stylename,'. ','_')"/>

  <xsl:if test="$stylename">
.<xsl:value-of select="$style-prefix"/> .<xsl:value-of
   select="$style-prefix"/>_<xsl:value-of select="$final-stylename"/> {
<xsl:apply-templates mode="stylesheet"/>}
</xsl:if>
</xsl:template>

<!-- wow this sucks -->
<xsl:template name="nbsp">
<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
</xsl:template>

<!-- modeled from sx2ml -->
<xsl:template name="pixels">
	<xsl:param name="value"/>

	<xsl:variable name="cm-in-mm" select="10" />
	<xsl:variable name="in-in-mm" select="25.4" />
	<xsl:variable name="px-in-mm" select="$in-in-mm div $dpi" />

	<xsl:variable name="no-of-mm" select="number(translate($value,'cminh', '')) div $px-in-mm"/>

	<xsl:choose>
		<xsl:when test="contains($value, 'mm')">
			<xsl:value-of select="ceiling($no-of-mm * 1)"/>px
		</xsl:when>
		<xsl:when test="contains($value, 'cm')">
			<xsl:value-of select="ceiling($no-of-mm * $cm-in-mm)"/>px
		</xsl:when>
		<xsl:when test="contains($value, 'in')">
			<xsl:value-of select="ceiling($no-of-mm * $in-in-mm)"/>px
		</xsl:when>
		<xsl:otherwise>
		        <!-- not in/cm/mm, just return value -->
			<xsl:value-of select="$value" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
