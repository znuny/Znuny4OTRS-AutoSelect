# --
# Copyright (C) 2012-2020 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::Znuny4OTRSAutoSelect;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

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

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $JSONObject   = $Kernel::OM->Get('Kernel::System::JSON');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $AutoSelectConfig = $ConfigObject->Get('Znuny4OTRSAutoSelect');
    return if !IsHashRefWithData($AutoSelectConfig);

    my @FieldIDs;
    FIELD:
    for my $FieldID ( sort keys %{ $AutoSelectConfig->{FieldIDs} } ) {
        next FIELD if $AutoSelectConfig->{FieldIDs}->{$FieldID} == 0;
        push @FieldIDs, $FieldID;
    }
    return if !@FieldIDs;

    my $FieldIDs = $JSONObject->Encode(
        Data => \@FieldIDs,
    );

    my $JSBlock = <<"JS";
Core.Agent.Znuny4OTRSAutoSelect.Init({
    SelectAlways: $AutoSelectConfig->{SelectAlways},
    ConfigHide:   $AutoSelectConfig->{HideFields},
    FieldIDs:     $FieldIDs
});
JS

    $LayoutObject->AddJSOnDocumentCompleteIfNotExists(
        Key  => 'Znuny4OTRSAutoSelect',
        Code => $JSBlock,
    );

    return;
}
1;
