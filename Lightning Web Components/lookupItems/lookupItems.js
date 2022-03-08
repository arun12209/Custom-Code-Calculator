import { LightningElement,api, wire } from 'lwc';
import searchRecords from '@salesforce/apex/LookupController.findRecords';
export default class LookupItems extends LightningElement {

    @api objName;
    @api iconName;
    @api filterField = '';
    @api searchPlaceholder='Search';
    
    selectedName;
    records;
    isValueSelected;
    blurTimeout;
    searchKey;

    boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    inputClass = '';

    @wire(searchRecords, {searchKey: '$searchKey', objectName: '$objName', filterField:'$filterField'})
    wiredRecords({error,data}){

        if(data){

            this.records = data;
            this.error = undefined;
        }
        else if(error){
            this.error = error;
            this.records = undefined;

        }
    }

    handleClick() {
        this.searchKey = '';
        this.inputClass = 'slds-has-focus';
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open';
    }

    onBlur() {
        this.blurTimeout = setTimeout(() =>  {
            this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'
        }, 900);
    }

    onSelect(event) {

        console.log('Selected Apex class: ' + JSON.stringify(event.currentTarget.dataset));

        //get selected record id
        let selectedId = event.currentTarget.dataset.id;

        //get selected record name
        let selectedName = event.currentTarget.dataset.name;

        const valueSelectedEvent = new CustomEvent('lookupselected', {detail:  selectedId });
        //fire an custom event
        this.dispatchEvent(valueSelectedEvent);

        this.isValueSelected = true;

        this.selectedName = selectedName;

        if(this.blurTimeout) {

            clearTimeout(this.blurTimeout);
        }

        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    }

    handleRemovePill() {
        this.isValueSelected = false;
    }

    onChange(event) {

        this.searchKey = event.target.value;
    }
}
