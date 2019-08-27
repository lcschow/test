set serveroutput on;

DECLARE
p_scheme_code	VARCHAR2(8) := 'NLSFT';
p_position_date DATE := TO_DATE('20190430','YYYYMMDD');
n_deferment_interest	NUMBER;
n_si_virtual_settled	NUMBER;
n_ii_virtual_settled	NUMBER;
n_principal_due_to_def  NUMBER;
BEGIN

	FOR i IN (SELECT loan_ref_num, scheme_code, position_date, principal_due_to_def
			FROM nls_rep_stat_loan_rep
			WHERE scheme_code = p_scheme_code
			AND position_date = p_position_date
            AND principal_due_to_def > 0) LOOP
			
          SELECT NVL(SUM(a.principal_due_to_deferment), 0)
			INTO n_deferment_interest
          FROM nls_rep_deferment_histories a
          WHERE a.void_ind = 'N'
            AND a.nli_loan_ref_num = i.loan_ref_num
			AND a.scheme_code = i.scheme_code
            AND a.approval_date <= i.position_date;

          
          SELECT NVL(SUM(b.study_interest_paid), 0),
                 NVL(SUM(b.instal_interest_paid), 0)
          INTO   n_si_virtual_settled, n_ii_virtual_settled
          FROM   nls_rep_trans_histories a,
                 nls_rep_trans_components b
          WHERE  a.nls_rep_trans_histories_id = b.nls_rep_trans_histories_id
            AND b.nli_loan_ref_num = i.loan_ref_num
            AND a.reject_ind = 'N'
            AND a.payment_method = 'X'
            AND TRUNC(a.nrth_date) <= i.position_date;

          n_principal_due_to_def := n_deferment_interest + n_si_virtual_settled + n_ii_virtual_settled;
		  
		dbms_output.put_line(i.scheme_code || ',' || i.loan_ref_num || ',' || n_deferment_interest || ',' || n_si_virtual_settled || ',' || n_ii_virtual_settled || ',' || n_principal_due_to_def  || ',' || i.principal_due_to_def );		  
	
	END LOOP;
END;	  