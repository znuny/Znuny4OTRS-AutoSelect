# Automatic selection if only on item exists

This package contains the functionality to select and hide automatically the following fields, if only one value is available.

 - Priority
 - Queue
 - Service
 - SLA
 - State
 - Type
 - Responsible
 - Owner
 - ArticleType
 - ProcessEntity

## Configuration

Following settings can be made in the SysConfig.

#### Znuny4OTRSAutoSelect###HideFields
Defines which valid FieldIDs should be hidden if only one value is available.

#### Znuny4OTRSAutoSelect###SelectAlways"
Defines if all valid FieldIDs should be always selected if only one value is available.
If you activate this function, you can't select an empty value (-).

#### Znuny4OTRSAutoSelect###FieldIDs
This configuration registers possible FieldIDs for autoselection. 1 = enabled, 0 = disabled.
You can also use dynamic fields by adding them to the list of FieldIDs.

Indication of the dynamic fields:

- DynamicField_field1
- DynamicField_NameOfField

![Example DynamicField_feld1](doc/en/images/DynamicFields.png)

The functionality relates to following screens:

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
