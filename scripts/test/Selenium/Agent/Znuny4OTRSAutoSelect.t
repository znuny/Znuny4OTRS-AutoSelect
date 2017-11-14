# --
# Copyright (C) 2012-2017 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

use vars (qw($Self));

# get the Znuny4OTRS Selenium object
my $SeleniumObject = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

# store test function in variable so the Selenium object can handle errors/exceptions/dies etc.
my $SeleniumTest = sub {

    # initialize Znuny4OTRS Helpers and other needed objects
    my $HelperObject      = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
    my $ZnunyHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');

    # Usable Snippets (SublimeTextAdjustments):
    #     otrs.dynamicfield.config.text
    #     otrs.dynamicfield.config.checkbox
    #     otrs.dynamicfield.config.datetime
    #     otrs.dynamicfield.config.dropdown
    #     otrs.dynamicfield.config.textarea
    #     otrs.dynamicfield.config.multiselect

    my @DynamicFields = (
        {
            Name          => 'Znuny4OTRSAutoSelectTest',
            Label         => "Znuny4OTRSAutoSelectTest",
            ObjectType    => 'Ticket',
            FieldType     => 'Dropdown',
            InternalField => 0,
            Config        => {
                PossibleValues => {
                    Visible => 'Visible',
                    Hidden  => 'Hidden',
                },
                DefaultValue       => "Hidden",
                TreeView           => '0',
                PossibleNone       => '1',
                TranslatableValues => '0',
                Link               => '',
            },
        },
    );
    $ZnunyHelperObject->_DynamicFieldsCreateIfNotExists(@DynamicFields);

    my %Screens = (
        AgentTicketPhone => {
            Znuny4OTRSAutoSelectTest => 1,
        },
    );
    $ZnunyHelperObject->_DynamicFieldsScreenEnable(%Screens);

    my $TestACL = {
        Properties => {
            Frontend => {
                Action => ['AgentTicketPhone'],
            },
        },
        PropertiesDatabase => {},
        Possible           => {
            Ticket => {
                Queue                                 => ['Raw'],
                State                                 => ['open'],
                Priority                              => ['3 normal'],
                DynamicField_Znuny4OTRSAutoSelectTest => ['Visible'],
            },
        },
        PossibleAdd => {},
        PossibleNot => {},
    };

    $HelperObject->ConfigSettingChange(
        Valid => 1,
        Key   => 'TicketAcl###23-Znuny4OTRSAutoSelectTest',
        Value => $TestACL,
    );

    $HelperObject->ConfigSettingChange(
        Valid => 1,
        Key   => 'Znuny4OTRSAutoSelect###FieldIDs',
        Value => {
            PriorityID                            => 1,
            QueueID                               => 1,
            StateID                               => 1,
            DynamicField_Znuny4OTRSAutoSelectTest => 1,
        },
    );

    # create test user and login
    my %TestUser = $SeleniumObject->AgentLogin(
        Groups => [ 'admin', 'users' ],
    );

    $SeleniumObject->AgentInterface(
        Action      => 'AgentTicketPhone',
        WaitForAJAX => 0,
    );

    my %ValueMap = (
        PriorityID                            => '',
        QueueID                               => 'Raw',
        StateID                               => 'open',
        PriorityID                            => '3 normal',
        DynamicField_Znuny4OTRSAutoSelectTest => 'Visible',
    );

    for my $Attribute ( sort keys %ValueMap ) {
        my $SelectedValue = $SeleniumObject->InputGet(
            Attribute => $Attribute,
            Options   => {
                KeyOrValue => 'Value',
                }
        );

        my $ExpectedValue = $ValueMap{$Attribute};
        $Self->Is(
            $SelectedValue,
            $ExpectedValue,
            "$Attribute is $ExpectedValue",
        );

        my $FieldID = $SeleniumObject->InputFieldID(
            Attribute => $Attribute,
        );
        my $IsDisplayed = $SeleniumObject->find_element( "#${FieldID}_Search", 'css' )->is_displayed();
        $Self->True( $IsDisplayed, "$Attribute is displayed" );
    }

    $HelperObject->ConfigSettingChange(
        Valid => 1,
        Key   => 'Znuny4OTRSAutoSelect###HideFields',
        Value => 1,
    );

    $SeleniumObject->VerifiedRefresh();

    for my $Attribute ( sort keys %ValueMap ) {
        my $FieldID = $SeleniumObject->InputFieldID(
            Attribute => $Attribute,
        );
        my $IsHidden = $SeleniumObject->find_element( "#${FieldID}_Search", 'css' )->is_hidden();
        $Self->True( $IsHidden, "$Attribute is hidden" );
    }
};

# finally run the test(s) in the browser
$SeleniumObject->RunTest($SeleniumTest);

1;
