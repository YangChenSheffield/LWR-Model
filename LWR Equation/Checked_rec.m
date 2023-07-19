function ht = Checked_rec(rec,hf)
% ht = Checked_rec(rec,hf)  ht = Checked_rec(rec)
% ht = Checked_rec(hc,hf)   ht = Checked_rec(hc)
% 将句柄hf指定figure中的区域rec使用矩形标识出来，方便辨认该区域
% By ZFS@wust 2011
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

if ~exist('hf','var')
    hf = gcf;
end
    
if [ishandle( rec(1) ) && length(rec)>1] || iscell( rec(1) )    % 输入矩阵
    for ii = 1:length(rec)
       ht(ii) = Checked_rec(rec(ii),hf);
    end
else                                                            % 输入标量
    
    if ishandle(rec)
        if ischild(rec,hf)
            hc = rec;
            rec = get(hc,'position');
        else
            error('输入句柄不为figure对象的子对象');
        end
    end
    
    ht = annotation(hf,'rectangle',rec);
    set(ht,'color','r')
    
end
