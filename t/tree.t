use TestML;

TestML->new(
    testml => 'testml/tree.tml',
    bridge => 't::Bridge',
    compiler => 'TestML::Compiler::Lite',
)->run;
