# Konfiguration

In der SysConfig können folgende Einstellungen getätigt werden.

#### Znuny4OTRSAutoSelect###HideFields
Legt fest, ob die Felder der validen FieldIDs ausgeblendet werden, wenn nur ein Wert verfügbar ist.

#### Znuny4OTRSAutoSelect###SelectAlways"
Legt fest, ob die Felder der validen FieldIDs immer ausgewählt werden, wenn nur ein Wert verfügbar ist.
Wenn Sie diese Funktion aktivieren, können Sie keinen leeren Wert wählen (-).

#### Znuny4OTRSAutoSelect###FieldIDs
Zusätzlich kann diese Funktion auch für dynamische Felder verwendet werden.
Ergänzen Sie hierzu einfach nur die Liste der FieldIDs.

Angabe der dynamischen Felder:

- DynamicField_feld1
- DynamicField_NameOfField

![Beispiel DynamicField_feld1](doc/de/images/DynamicFields.png)

Die Funktionalität betrifft die Masken:

 - AgentTicketPhone
 - AgentTicketEmail
 - AgentTicketActionCommon
 - AgentTicketFreeText
 - AgentTicketPriority
 - AgentTicketOwner
 - AgentTicketNote
 - AgentTicketClose
 - AgentTicketPending
 - AgentTicketMove
 - AgentTicketPhoneCommon
 - AgentTicketBulk
 - AgentTicketProcess
 - AgentTicketProcessSmall
 - CustomerTicketProcess
 - CustomerTicketMessage
 - AgentTicketCompose
 - AgentTicketBounce
