// --
// Copyright (C) 2012 Znuny GmbH, https://znuny.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --
// nofilter(TidyAll::Plugin::Znuny::JavaScript::ESLint)

'use strict';

var Core   = Core       || {};
Core.Agent = Core.Agent || {};

/**
 * @namespace
 * @exports TargetNS as Core.Agent.ZnunyAutoSelect
 * @description
 *      This namespace contains a function for hiding the fields Priority, Queue, Service, SLA, State, Type, Responsible and Owner, if only one value is available.
 */
Core.Agent.ZnunyAutoSelect = (function (TargetNS) {

    var Store = {};

    TargetNS.Init = function (Param) {
         var ParamCheckSuccess = true;
         var SelectAlways;
         var ConfigHide;
         var Attributes;

        $.each(['SelectAlways', 'ConfigHide', 'FieldIDs'], function (Index, ParameterName) {
            if (!Param.hasOwnProperty(ParameterName)) {
                ParamCheckSuccess = false;
            }
        });

        if (!ParamCheckSuccess) {
            return false;
        }

        // remember params
        SelectAlways = Param['SelectAlways'];
        ConfigHide   = Param['ConfigHide'];
        Attributes   = Param['FieldIDs'];

        // inital check
        $(document).ready(function(){
            TargetNS.CheckField(SelectAlways, ConfigHide, Attributes);
        });

        // checked everytime
        Core.App.Subscribe('Event.AJAX.FormUpdate.Callback', function() {
            TargetNS.CheckField(SelectAlways, ConfigHide, Attributes);
        });
        Core.App.Subscribe('Event.AJAX.FunctionCall.Callback', function() {
            TargetNS.CheckField(SelectAlways, ConfigHide, Attributes);
        });

        // checked everytime
        Core.App.Subscribe('TicketProcess.Init.FirstActivityDialog.Load', function() {
            TargetNS.CheckField(SelectAlways, ConfigHide, Attributes);
        });
    }

    TargetNS.CheckField = function (SelectAlways, ConfigHide, Attributes) {

        $.each(Attributes, function(Index, Attribute) {
            var Values = [];

            var RawValues = Znuny.Form.Input.Get(Attribute, { PossibleValues: true });
            var FieldID   = Znuny.Form.Input.FieldID(Attribute);

            if (!FieldID) return true;

            RawValues = RawValues || [];

            // remove possible empty value
            $.each(RawValues, function(Index, Value) {
                if (Value == '-') return true;
                if (Value == '') return true;
                if (Value == ' ') return true;

                // get all options
                Values.push(Value);
            });

            // return if attribute has a stored value
            if(
                SelectAlways == 0
                && Znuny.Form.Input.Get(Attribute) == ''
                && Store[Attribute]
            ) {
                return true;
            }

            if (Values.length == 1) {

                // select option
                if (Znuny.Form.Input.Get(Attribute) != Values[0]) {
                    Znuny.Form.Input.Set(Attribute, Values[0]);

                    // store auto selected value for attribute
                    Store[Attribute] = Values[0];
                }

                // hide field
                if (ConfigHide == 1) {
                    Znuny.Form.Input.Hide(Attribute);
                }
            }
            else if (ConfigHide == 1) {
                // select show
                Znuny.Form.Input.Show(Attribute);
            }
        });
    }

    return TargetNS;
}(Core.Agent.ZnunyAutoSelect || {}));
