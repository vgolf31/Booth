//
//  QuestionsViewController.swift
//  Booth
//
//  Created by Veer M on 7/19/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var question_label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var next_button: UIButton!
    var questions:[[String]] = [
        ["How much money should you put into savings every month?", "2% of each paycheck", "10% of each paycheck", "All free cash flow you have left at the end of the month", "Anything you can", "2"],
        ["What are the 5 factors that add up to make your credit score?", "Amount owed + highest interest rate + number of cards + delinquencies + overage", "Gross income + number of cards + payment history + penalties + savings", "Nice smile + winning attitude + promise to be more responsible + the right credit score incantation + eye of newt", "Payment history + utilization ratio + new applications + length of use + kinds of credit", "4"],
        ["What’s the most income you should use on monthly credit card payments?", "None. Why pay, when you can just dodge the collectors?", "As much as it takes to pay off your debts in-full every month", "No more than 10% of what you bring home", "No more than 30% of your gross income", "3"],
        ["What’s the maximum debt-to-income ratio you should have to maintain financial stability?", "No more than 27%", "No more than 41%", "No more than 50%", "As long as you have more income than debt, you’re golden!", "2"],
        ["How often can you check your credit report for free?", "It depends on how many “free” credit score sites you can sign up for", "Once every six months", "Once every year", "Never. You always have to pay if you want your real report", "3"],
        ["How much money do you need for a down payment on a traditional mortgage?", "5% of the amortization on the loan", "However much money you can get in payday loans the day you apply", "At least 20% of the purchase price", "At least $20,000", "3"],
        ["What does APR stand for?", "Annual penalty rate", "Applied percentage rate", "Acutely painful responsibilities", "Annual percentage rate", "4"],
        ["How is net worth calculated?", "Assets – liabilities", "Credit score x income", "Personal marketability / laziness", "Income – debt", "1"],
        ["How soon should you check your credit prior to a major purchase?", "The lender should check it for you when you apply", "At least 6 weeks before", "At least 6 months prior", "Any purchase that requires a credit check is too expensive anyway", "3"],
        ["How many payments do you have to make before penalty APR can be removed?", "6 payments in a one year period", "None. You just apply for a new credit card when penalty APR is applied", "At least 6 consecutive payments", "Penalty APR can never be removed once applied", "3"],
        ["What are the 3 C’s of credit worthiness?", " Capacity, character, collateral", "Capital, credibility, creed", "Comedic value, chemical dependency, can-do spirit", "Charge offs, credit score, costs", "1"],
        ["What are the three types of expenses in your budget?", "Flexible, Floating, Fixed", "Wants, Needs, Bills", "Fixed, Flexible, Discretionary", "Pay now, pay next month, pay upon death", "3"],
        ["What kind of credit card can you get with bad credit or no credit score?", "Any, as long as you can find a cosigner", "Secured", "Remedial", "Probationary", "2"],
        ["What federal law protects your rights from abusive collection tactics?", "Fair Credit Reporting Act (FCRA)", " Collection Abuse Litigation Law (CALL)", "Fair Debt Collection Practices Act (FDCPA)", " Abuse Standards Infraction Filing (ASIF)", "3"],
        ["How long does it take for an account to go to collections?", "After 30 days of nonpayment", " Usually after six months without a payment", "One year of nonpayment", "Once they realize you’ve skipped town", "2"],
        ["What are the names of the three big credit bureaus in the U.S.?", "Experian, Equifax, TransUnion", "Visa, MasterCard, AMEX", "Wells Fargo, TD, Bank of America", "Volcker, Greenspan, Bernake", "1"],
        ["What are the two types of personal bankruptcy filings you can make?", "Filtered and Unfiltered", "Chapter 9 and Chapter 11", "Fixed and Revolving", "Chapter 7 and Chapter 13", "4"],
        ["How long do credit inquiries affect your credit score?", "Forever", "For about five years", "For about 6 months", "From the time they’re made until your new credit line is opened", "3"],
        ["What’s the retirement plan that you get through your employer called?", "Roth IRA", "401(k)", "Traditional IRA", "Social security", "2"],
        ["What debts cannot be discharged by bankruptcy?", "Payday loans, cash advances, short-term installment loans", "Debts secured with collateral worth more than $100,000", "Any debt can be discharged. Bankruptcy is a get out of jail free card.", "Student loans, child support, alimony, court judgments", "4"]
    ]
    var current_question = 0
    var current_values = [String]()
    override func viewDidLoad() {
        next_button.tintColor = UIColor.white
        updateVals()
        super.viewDidLoad()
    }
    @IBAction func button1_clicked(_ sender: Any) {
        if(current_values[5] == "1"){
            button1.tintColor = UIColor.systemGreen
            current_question += 1
        } else{
            button1.tintColor = UIColor.systemRed
            next_button.setTitle("Start Over", for: .normal)
            current_question = 0
        }
        button1.isUserInteractionEnabled = false
        button2.isUserInteractionEnabled = false
        button3.isUserInteractionEnabled = false
        button4.isUserInteractionEnabled = false
        next_button.isUserInteractionEnabled = true
        next_button.isHidden = false
    }
    @IBAction func button2_clicked(_ sender: Any) {
        if(current_values[5] == "2"){
            button2.tintColor = UIColor.systemGreen
            current_question += 1
        } else{
            button2.tintColor = UIColor.systemRed
            next_button.setTitle("Start Over", for: .normal)
            current_question = 0
        }
        button1.isUserInteractionEnabled = false
        button2.isUserInteractionEnabled = false
        button3.isUserInteractionEnabled = false
        button4.isUserInteractionEnabled = false
        next_button.isUserInteractionEnabled = true
        next_button.isHidden = false
    }
    @IBAction func button3_clicked(_ sender: Any) {
        if(current_values[5] == "3"){
            button3.tintColor = UIColor.systemGreen
            current_question += 1
        } else{
            button3.tintColor = UIColor.systemRed
            next_button.setTitle("Start Over", for: .normal)
            current_question = 0
        }
        button1.isUserInteractionEnabled = false
        button2.isUserInteractionEnabled = false
        button3.isUserInteractionEnabled = false
        button4.isUserInteractionEnabled = false
        next_button.isUserInteractionEnabled = true
        next_button.isHidden = false
    }
    @IBAction func button4_clicked(_ sender: Any) {
        if(current_values[5] == "4"){
            button4.tintColor = UIColor.systemGreen
            current_question += 1
        } else{
            button4.tintColor = UIColor.systemRed
            next_button.setTitle("Start Over", for: .normal)
            current_question = 0
        }
        button1.isUserInteractionEnabled = false
        button2.isUserInteractionEnabled = false
        button3.isUserInteractionEnabled = false
        button4.isUserInteractionEnabled = false
        next_button.isUserInteractionEnabled = true
        next_button.isHidden = false
    }
    @IBAction func nextbutton_clicked(_ sender: Any) {
        button1.isUserInteractionEnabled = true
        button2.isUserInteractionEnabled = true
        button3.isUserInteractionEnabled = true
        button4.isUserInteractionEnabled = true
        button1.tintColor = UIColor.white
        button2.tintColor = UIColor.white
        button3.tintColor = UIColor.white
        button4.tintColor = UIColor.white
        next_button.isUserInteractionEnabled = false
        next_button.isHidden = true
        next_button.setTitle("Next Question", for: .normal)
        updateVals()
    }
    func updateVals() {
        if(current_question == questions.count){
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            {
                present(vc, animated: false, completion: nil)
            }
        } else{
            current_values = questions[current_question]
            question_label.text = current_values[0] + " (" + String(current_question+1) + "/" + String(questions.count) + ")"
            button1.setTitle(current_values[1], for: .normal)
            button2.setTitle(current_values[2], for: .normal)
            button3.setTitle(current_values[3], for: .normal)
            button4.setTitle(current_values[4], for: .normal)
        }
    }

}
