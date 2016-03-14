# --
# Copyright (C) 2012-2016 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_Znuny4OTRSAutoSelect;

use strict;
use warnings;

use utf8;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{"This configuration registers possible FieldIDs for autoselection. 1 = active, 0 = deactive. You can also use dynamicfields: DynamicField_NameOfField."} = "Diese Konfiguration registriert alle möglichen FieldIDs für die Autoselektion. 1 = aktiv, 0 = deaktiv. Sie können auch dynamische Felder verwenden: DynamicField_NameOfField.";
    $Self->{Translation}->{"Defines if all valid FieldIDs should be hidden if only one value is available."} = "Legt fest, ob die Felder der validen FieldIDs ausgeblendet werden, wenn nur ein Wert verfügbar ist.";
    $Self->{Translation}->{"This configuration registers an output filter for js, that automaticly select all valid FieldIDs value if only one is available."} = "Diese Konfiguration registriert einen OutputFilter, welches automatisch den Wert für die gültigen FieldIDs setzt, wenn nur einer zur Verfügung steht.";
    $Self->{Translation}->{"Defines if all valid FieldIDs should be always selected if only one value is available. If you activate this function, you can't select an empty value (-)."} = "Legt fest, ob die Felder der validen FieldIDs immer ausgewählt werden, wenn nur ein Wert verfügbar ist. Wenn Sie diese Funktion aktivieren, können Sie keinen leeren Wert wählen (-).";

    return 1;
}

1;
