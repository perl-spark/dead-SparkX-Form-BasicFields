package SparkX::Form::Field::Select;

use Moose;
use HTML::Tiny;

extends 'Spark::Form::Field';
with 'Spark::Form::Field::Role::Printable::HTML',
     'Spark::Form::Field::Role::Printable::XHTML';

has '+value' => (
    isa => 'Str',
);

has options => (
    isa => 'ArrayRef',
    is => 'rw',
    required => 0,
    lazy => 1,
    default => sub { shift->value },
);

sub to_html {
    shift->_render( HTML::Tiny->new( mode => 'html') );
}

sub to_xhtml {
    shift->_render( HTML::Tiny->new( mode => 'xml') );
}
 
sub _render {
    my ($self,$html) = @_;
    $html->select({name => $self->name},
        join(' ',map {
            $html->option({
                value => $_,
                (($self->value eq $_) ? (selected => 'selected') : ()),
            }, $_);
        } @{$self->options}),
    );
}

1;
__END__

=head1 NAME

SparkX::Form::Field::Select - A select dropdown field for SparkX::Form

=head1 METHODS

=head2 to_html() => Str

Renders the field to html

=head2 to_xhtml() => Str

Renders the field to xhtml

=head1 SEE ALSO

L<SparkX::Form> - The forms module this is to be used with
L<SparkX::Form::BasicFields> - A collection of fields for use with C<Spark::Form>

=cut
