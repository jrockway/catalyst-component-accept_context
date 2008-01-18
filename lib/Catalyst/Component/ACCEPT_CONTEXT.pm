package Catalyst::Component::ACCEPT_CONTEXT;

use warnings;
use strict;
use NEXT;
use Scalar::Util qw(weaken);

=head1 NAME

Catalyst::Component::ACCEPT_CONTEXT - Make the current Catalyst
request context available in Models and Views.

=head1 VERSION

Version 0.05

=cut

our $VERSION = '0.05';

=head1 SYNOPSIS

Models and Views don't usually have access to the request object,
since they probably don't really need it.  Sometimes, however, having
the request context available outside of Controllers makes your
application cleaner.  If that's the case, just use this module as a
base class:

    package MyApp::Model::Foobar;
    use base qw|Catalyst::Component::ACCEPT_CONTEXT Catalyst::Model|;

Then, you'll be able to get the current request object from within
your model:

    sub do_something {
        my $self = shift;
        print "The current URL is ". $self->context->req->uri->as_string;
    }

=head1 METHODS

=head2 context

Returns the current request context.

=cut

sub context {
    return shift->{context};
}

=head2 ACCEPT_CONTEXT

Catalyst calls this method to give the current context to your model.
You should never call it directly.

Note that a new instance of your component isn't created.  All we do
here is shove C<$c> into your component.  ACCEPT_CONTEXT allows for
other behavior that may be more useful; if you want something else to
happen just implement it yourself.

See L<Catalyst::Component> for details.

=cut

sub ACCEPT_CONTEXT {
    my $self    = shift;
    my $context = shift;

    $self->{context} = $context;
    weaken($self->{context});
    
    return $self->NEXT::ACCEPT_CONTEXT($context, @_) || $self;
}

=head2 COMPONENT

Overridden to use initial application object as context before a request.

=cut

sub COMPONENT {
    my $class = shift;
    my $app   = shift;
    my $args  = shift;
    $args->{context} = $app;
    weaken($args->{context}) if ref $args->{context};
    return $class->NEXT::COMPONENT($app, $args, @_);
}

=head1 AUTHOR

Jonathan Rockway, C<< <jrockway at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-catalyst-component-accept_context at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Component-ACCEPT_CONTEXT>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Component::ACCEPT_CONTEXT

You can also look for information at:

=over 4

=item * Catalyst Website

L<http://www.catalystframework.org/>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Component-ACCEPT_CONTEXT>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Component-ACCEPT_CONTEXT>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Component-ACCEPT_CONTEXT>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Component-ACCEPT_CONTEXT>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2007 Jonathan Rockway.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Catalyst::Component::ACCEPT_CONTEXT
