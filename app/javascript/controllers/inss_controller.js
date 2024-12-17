import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["salary", "inss"];

  connect() {
    console.log("INSS Controller conectado!");
  }

  calculate() {
    const salary = parseFloat(this.salaryTarget.value) || 0;
    const inss = this.calculateINSS(salary);
    this.inssTarget.value = inss.toFixed(2);
  }

  calculateINSS(salary) {
    let inss = 0;
  
    if (salary <= 1412.00) {
      inss = salary * 0.075;
    }
    else if (salary <= 2666.68) {
      inss = 1412.00 * 0.075 + (salary - 1412.00) * 0.09;
    }
    else if (salary <= 4000.03) {
      inss = 1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (salary - 2666.68) * 0.12;
    }
    else if (salary <= 7786.02) {
      inss = 1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 + (salary - 4000.03) * 0.14;
    }
    else {
      inss = 1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 + (7786.02 - 4000.03) * 0.14;
    }
    console.log(inss)
    return inss;
  }
  
}
