function ht = Checked_rec(rec,hf)
% ht = Checked_rec(rec,hf)  ht = Checked_rec(rec)
% ht = Checked_rec(hc,hf)   ht = Checked_rec(hc)
% �����hfָ��figure�е�����recʹ�þ��α�ʶ������������ϸ�����
% By ZFS@wust 2011
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans

if ~exist('hf','var')
    hf = gcf;
end
    
if [ishandle( rec(1) ) && length(rec)>1] || iscell( rec(1) )    % �������
    for ii = 1:length(rec)
       ht(ii) = Checked_rec(rec(ii),hf);
    end
else                                                            % �������
    
    if ishandle(rec)
        if ischild(rec,hf)
            hc = rec;
            rec = get(hc,'position');
        else
            error('��������Ϊfigure������Ӷ���');
        end
    end
    
    ht = annotation(hf,'rectangle',rec);
    set(ht,'color','r')
    
end
