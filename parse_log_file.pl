#!/usr/bin/perl -w
use strict;
use Data::Dumper;

=cut
<soapenv:Body><placeOrder><OrderRequest><DropShip><Order><OrderDetail><EmpNo/><program/><Retailer>11594060001</Retailer><PONumber/><CustomerContact>(973)465-0900</CustomerContact><ShippingMethod/><CustomerPO>170543-2</CustomerPO><Name>LARRY BOWER</Name><Address1>WEB ORDER 36123</Address1><Address2>847 GREENWOOD MEADOW LN.</Address2><City>BAKERSFIELD</City><State>CA</State><Zip>93308</Zip></OrderDetail><ProductDetail><LineID>1</LineID><UPC>00883248130964</UPC><Qty>1</Qty><EMB><EMBPlacement/><EMBDesignCode/><EMBStyle/><EMBFont/><EMBSize/><EMBColor/><EMBText1/><EMBText2/><EMBText3/><EMBCompLot/><EMBAS/><EMBNC/><EMBAttchType/><Instructions/></EMB></ProductDetail></Order></DropShip></OrderRequest><accessKey>9kB/iEsCsheXpG57gkq1/cadrkssPvRV</accessKey></placeOrder></soapenv:Body>
=cut

=cut
Fri Nov 16 00:01:40 EST 2018
<secureKey>wKclhSkWO7ki51F68PfRqu9vl8hahOgp</secureKey><accessSign>PyOIpUBfbF9WS/ztoIxLWIiHhtR9mZmk</accessSign><retailerId>03259040000</retailerId>
=cut

my $count = 0;
my $index = {};
while(<>) {
	chomp;
	next unless /SOAP Request/;
	my $stamp = $1 if /^(.*\S)\s+SOAP Request/;
	my $retailer = '';
	my $type = $2 if /<[^>]+:Body><(\w+:)?(\w+)/;
	if ($type) {
		$index->{$type}++;
		if (/<([^\>]+:)?loginCred[^>]*>(.*)<[^>]*loginCred/) {
		#if (/<([^\>]+:)?loginCred>(.*)<\/([^>]+:)?loginCred>/) {
			my $loginCred = $2;
			my $secureKey = $1 if $loginCred =~ /<secureKey>(.*)<\/secureKey>/;
			my $accessSign = $1 if $loginCred =~ /<accessSign>(.*)<\/accessSign>/;
			my $retailerId = $1 if $loginCred =~ /<retailerId>(.*)<\/retailerId>/;
			$retailerId = '' unless $retailerId;
			$secureKey = '' unless $secureKey;
			$accessSign = '' unless $accessSign;
			print join("\t", $stamp, $retailerId, $type, $secureKey, $accessSign) . "\n";
		}
		#if (/<Retailer>(\w+)<\/Retailer>/) {
		#	$retailer = $1;
		#	print join("\t", $retailer, $type) . "\n";
		#}
	}
}

#print Dumper($index);
