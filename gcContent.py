#!/usr/bin/env python2.7

# gc content of a DNA string
def compute_gc_content(seq):
	g_cont = base_composition(seq, "G");
	c_cont = base_composition(seq, "C");
	gc_cont = g_cont + c_cont;
	return(gc_cont);

 # defines a bp in
# DNA string & returns % base composition
def base_composition(seq, base):
	base_counter = 0
	seq_len = len(seq);
	for index in range (0, seq_len):
		seq_base = seq[index];
		if(seq_base == base):
			base_counter = base_counter +1;
    base_percent = float(base_counter)/float(seq_len);
    return(base_percent);

# Let's create a list of dna sequences
seqs_list = list();
seqs_list.append("ACGA");
seqs_list.append("ACCG");
seqs_list.append("CCGC");
# and print the GC content of each
for seq in seqs_list:
    seq_gc = compute_gc_content(seq);
    print(str(seq_gc) + " : " + seq);
