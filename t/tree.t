# BEGIN { $TestML::Test::Differences = 1 }
# BEGIN { $Pegex::Parser::Debug = 1 }

use t::FakeTestML;

require_or_skip('YAML::XS');

# plan tests => 12;

my @files = qw(
    t/tree.tml
    t/tree-pegex.tml
);
for my $file (@files) {
    data($file);

    label('Normal Tree - $label');
    loop([
        ['yaml',['parse', 'Pegex::Tree', '*grammar', '*input']],
        '==',
        '*tree'
    ]);

    label('Wrapper Tree - $label');
    loop([
        ['yaml',['parse', 'Pegex::Tree::Wrap', '*grammar', '*input']],
        '==',
        '*wrap'
    ]);
}

done_testing;

use Pegex;
use YAML::XS;

sub parse {
    my ($receiver, $grammar, $input) = @_;
    my $parser = pegex($grammar, receiver => $receiver);
    return $parser->parse($input);
}

sub yaml {
    my ($data) = @_;
    my $yaml = YAML::XS::Dump($data);
    $yaml =~ s/^---\s+//;
    $yaml =~ s/'(\d+)':/$1:/g;
    return $yaml;
}
