#Entry   Protein names   Subcellular location    Pathway Gene ontology (GO)      Gene ontology IDs
#Q9SIT5  Cation/H(+) antiporter 15 (Protein CATION/H+ EXCHANGER 15) (AtCHX15)    Membrane; Multi-pass membrane protein.          integral component of membrane; potassium ion transport; regulation of pH; solute:hydrogen antiporter activity  GO:0016021; GO:0006813; GO:0006885; GO:0015299
#Q9FFR9  Cation/H(+) antiporter 18 (Protein CATION/H+ EXCHANGER 18) (AtCHX18)    Membrane; Multi-pass membrane protein.          integral component of membrane; late endosome; potassium ion transport; regulation of pH; solute:hydrogen antiporter activity   GO:0016021; GO:0005770; GO:0006813; GO:0006885; GO:0015299
#Q9M353  Cation/H(+) antiporter 20 (Protein CATION/H+ EXCHANGER 20) (AtCHX20)    Endomembrane system; Multi-pass membrane protein.               cellular potassium ion homeostasis; endomembrane system; endoplasmic reticulum; integral component of membrane; potassium ion transport; protein targeting to vacuole; regulation of pH; solute:hydrogen antiporter activity; water homeostasis GO:0030007; GO:0012505; GO:0005783; GO:0016021; GO:0006813; GO:0006623; GO:0006885; GO:0015299; GO:0030104

if(@ARGV < 3){
	die "Usage:\n\tperl $0 <uniprotKB_web_file> <blastX_two_column_results> <output_file>\n";
}

open(IN, "$ARGV[0]");
while($line = <IN>){
	chomp $line;
	@tab = split(/\t/, $line);
	$new = $tab[1]."\t".$tab[2]."\t".$tab[3]."\t".$tab[4]."\t".$tab[5];
	$hash{"$tab[0]"} = "$new";
#	if($line =~ /^\[\S+\]\s*\S+\s*(.*)/){
#		$function = $1;
#	} elsif($line =~ /^\s+\S+\s+(\S+.*)$/) {
#		@ids = split(/\s+/, $1);
#		foreach $id (@ids){
#			$hash{"$id"} = $function;
#		}
	}
#}
close IN;

open(IN, "$ARGV[1]");
open(OUT, ">$ARGV[2]");
print OUT "Gene_id\tUniprot_id\tProtein_name\tLocation\tPathway\tGO_term\tGO_id\n";
while($line = <IN>){
	chomp $line;
	($id, $ID) = split(/\t/, $line);
	print OUT "$line\t$hash{$ID}\n";
}
close IN;
close OUT;
