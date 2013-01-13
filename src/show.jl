##############################################################################
#
# Basic printing of TextAnalysis types
#
##############################################################################

show(io::Any, d::AbstractDocument) = print(io, "A $(typeof(d))")
show(io::Any, crps::Corpus) = print(io, "A Corpus")

##############################################################################
#
# Pretty printing of TextAnalysis types
#
##############################################################################

function summary(d::AbstractDocument)
	o = ""
	o *= "A $(typeof(d))\n"
	o *= " * Language: $(language(d))\n"
	o *= " * Name: $(name(d))\n"
	o *= " * Author: $(author(d))\n"
	o *= " * Timestamp: $(timestamp(d))\n"
	if contains({TokenDocument, NGramDocument}, typeof(d))
		o *= " * Snippet: ***SAMPLE TEXT NOT AVAILABLE***"
	else
		sample_text = replace(text(d)[1:50], r"\s+", " ")
		o *= " * Snippet: $(sample_text)"
	end
	return o
end

function summary(crps::Corpus)
	n = length(crps.documents)
	n_s = sum(map(d -> typeof(d) == StringDocument, crps.documents))
	n_f = sum(map(d -> typeof(d) == FileDocument, crps.documents))
	n_t = sum(map(d -> typeof(d) == TokenDocument, crps.documents))
	n_ng = sum(map(d -> typeof(d) == NGramDocument, crps.documents))
	o = ""
	o *= "A Corpus with $n documents:\n"
	o *= " * $n_s StringDocument's\n"
	o *= " * $n_f FileDocument's\n"
	o *= " * $n_t TokenDocument's\n"
	o *= " * $n_ng NGramDocument's\n\n"
	o *= "Corpus's lexicon contains $(lexicon_size(crps)) tokens\n"
	o *= "Corpus's index contains $(index_size(crps)) tokens"
	return o
end

##############################################################################
#
# In the REPL, show the summary by default
#
##############################################################################

repl_show(io::Any, d::AbstractDocument) = show(io, summary(d))
repl_show(io::Any, crps::Corpus) = show(io, summary(crps))
repl_show(io::Any, dtm::DocumentTermMatrix) = show(io, "A DocumentTermMatrix")
