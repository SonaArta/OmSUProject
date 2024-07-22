#ifndef BUTCHER_TABLE_HXX
#define BUTCHER_TABLE_HXX

#include<vector>
#include<cmath>
class Butcher_table
{
private:
    std::vector<std::vector<double>> coeff_A;
    std::vector<double> coeff_B;
    std::vector<double> coeff_C;
public:
    Butcher_table() = default;
    Butcher_table(std::vector<std::vector<double>>& m_A,
                  std::vector<double>& m_B, std::vector<double>& m_C)
                  : coeff_A(m_A), coeff_B(m_B), coeff_C(m_C)
    {}
    ~Butcher_table() = default;

    double get_A(int i, int j)
    {
        return coeff_A[i][j];
    }
     double get_B(int i)
    {
        return coeff_B[i];
    }
      double get_C(int i)
    {
        return coeff_C[i];
    }
};
#endif // BUTCHER_TABLE_HXX
