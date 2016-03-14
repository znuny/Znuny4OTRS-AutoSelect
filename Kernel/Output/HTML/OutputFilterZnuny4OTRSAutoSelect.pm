# --
# Kernel/Output/HTML/OutputFilterZnuny4OTRSAutoSelect.pm.pm
# Copyright (C) 2012-2016 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::OutputFilterZnuny4OTRSAutoSelect;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

use JSON;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::JSON',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = \%Param;
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $AutoSelectConfig = $Kernel::OM->Get('Kernel::Config')->Get('Znuny4OTRSAutoSelect');

    my @FieldIDs;
    FIELD:
    for my $FieldID ( sort keys %{ $AutoSelectConfig->{FieldIDs} } ) {
        next FIELD if $AutoSelectConfig->{FieldIDs}{$FieldID} eq 0;
        push @FieldIDs, $FieldID;
    }

    return if !IsArrayRefWithData( \@FieldIDs );
    my $FieldIDs = $Kernel::OM->Get('Kernel::System::JSON')->Encode(
        Data => \@FieldIDs,
    );

    # inject java script
    $Kernel::OM->Get('Kernel::Output::HTML::Layout')->AddJSOnDocumentComplete(
        Code =>
            "Core.Agent.Znuny4OTRSAutoSelect.Init({ SelectAlways:$AutoSelectConfig->{SelectAlways}, ConfigHide:$AutoSelectConfig->{HideFields}, FieldIDs:$FieldIDs });"
    );

    return $Param{Data};
}
1;
