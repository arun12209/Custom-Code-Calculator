import { LightningElement,api,wire } from 'lwc';
import getApexDetails from '@salesforce/apex/CustomCodeCalculatorController.getApexDetails';
import getApexLengthWithoutComments from '@salesforce/apex/CustomCodeCalculatorController.getApexLengthWithoutComments';
import getApexTypeOptions from '@salesforce/apex/CustomCodeCalculatorController.getApexType';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CustomCodeCalculator extends LightningElement {
    //apex class or trigger record id
    selectedApexId; 

    destinationApexRecord;
    lenghtInSourceOrg;

    lenghtInDestinationOrg;
    apexTypeOptions;

    lenghtDifference;
    selectedApexType;

    //difference percentage
    diffPercentage;
    percentagePlaceholder;

    searchPlaceholder;
    isLoading = false;
    displayResult = false;
    constructor() {
        super();
        this.selectedApexType = 'ApexClass';
        this.searchPlaceholder = 'Serach Apex Class';
    }
    
    handleSelection(event){
        
        this.displayResult = false;
        this.selectedApexId = event.detail;
        
    }
    
    async fetchDetails(){
        try{
            this.isLoading = true;

            if(this.selectedApexId != undefined && this.selectedApexId !=null){

                const sourceLengh = await getApexLengthWithoutComments({selectedApexRecordId : this.selectedApexId, apexType:this.selectedApexType});
                
                this.lenghtInSourceOrg = sourceLengh;

                const result = await getApexDetails({ apexRecordId: this.selectedApexId, apexType : this.selectedApexType });

                let obj = JSON.parse(result);

                if(obj.size == 0){
                    this.lenghtInDestinationOrg = '-';
                    this.lenghtDifference = this.lenghtInSourceOrg;
                    this.diffPercentage =  parseFloat( ((this.lenghtDifference * 100)/6000000).toFixed(3)); 
                }
                else{
                    this.lenghtInDestinationOrg = obj.records[0].LengthWithoutComments;
                    this.lenghtDifference = this.lenghtInSourceOrg - this.lenghtInDestinationOrg;
                    this.diffPercentage = parseFloat( ((this.lenghtDifference * 100)/6000000).toFixed(3));
                }

                this.displayResult = true;
                
                if(this.lenghtDifference>0){
                    this.percentagePlaceholder = 'Code Percentage Increased : ';
                }
                else if(this.lenghtDifference == 0){
                    this.percentagePlaceholder = 'Code Percentage : ';
                }
                else{
                    this.percentagePlaceholder = 'Code Percentage Decreased : ';
                }

                this.isLoading = false;
            }
            else{
                this.isLoading = false;
                let message = '';
                if(this.selectedApexId ==null){
                    message = 'Please select '+this.selectedApexType;
                }else{
                    message = 'Please select the Apex class or trigger';
                }
                const evt = new ShowToastEvent({
                    title: 'ERROR ',
                    message: message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            }
        }
        catch(error){
            console.log('Error: ' +error);
            this.isLoading = false;
            const evt = new ShowToastEvent({
                title: 'ERROR ',
                message: this.error,
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }
    }
    
    @wire(getApexTypeOptions) apexType({data,error}){
        if(data){
            let arrayOfMapKeys = [];
            let arrOption = [];
            //iterate over data returned from apex
            for (let singlekey in data) {
                 //push the apex type label in the array
                 arrayOfMapKeys.push(data[singlekey].Label);
            }
            //iterate over arrayOfMapKeys array
            for (let index = 0; index < arrayOfMapKeys.length; index++) { 
                //push the element in the array
                arrOption.push({ label: arrayOfMapKeys[index], value: arrayOfMapKeys[index]});
            }
            //apex type option
            this.apexTypeOptions = arrOption;
        }
        if(error){ //if any error
            console.log('error: '+this.error);
        }
    }

    apexTypeChangeHandler(event){
        this.displayResult = false;
        this.selectedApexId = null;
        this.selectedApexType = event.target.value;
        this.searchPlaceholder = 'Serach '+ this.selectedApexType;
    }

    handleClick(){
        this.fetchDetails();
    }
}
