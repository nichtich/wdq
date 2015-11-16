use v5.14;
use Test::More;
use Test::Output;

sub wdq {
    system( $^X, qw(script/wdq search --res t/examples/search.json), @_ );
}

my $text = <<TEXT;
Q256503: Ärzte
  Wikimedia-Begriffsklärungsseite
Q39631: Arzt (Ärzteschaft)
  Heilberuf
Q49330: Ärzte ohne Grenzen
Q245385: IPPNW (Ärzte für die Verhütung des Atomkrieges)
Q160721: Nürnberger Ärzteprozess (Ärzteprozess)
  Erster der zwölf Nürnberger Nachfolgeprozesse
Q256664: Ärzteverschwörung
Q695416: Poliklinik (Ärztehaus)
TEXT

stdout_is { wdq() } $text, 'text format by default in search mode';
stdout_is { wdq('-ftext') } $text, 'text format explicitly';

my $format = '{id}{label|pre==|length=3}{alias|length=14|align=right}';
stdout_is { wdq( '--format', $format, '-3' ) } <<TEXT, 'format string';
Q256503=Är…
Q39631=Ar…   Ärzteschaft
Q49330=Är…
TEXT

done_testing;
