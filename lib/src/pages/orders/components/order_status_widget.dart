import 'package:flutter/material.dart';
import 'package:fruittrace/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = <String, int> {
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };
  
  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    super.key,
    required this.status,
    required this.isOverdue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        const  _StatusDot(
          isActive: true,
          title: 'Pedido confirmado',
        ),

        const _CustomDivider(),

        if(currentStatus == 1) ...[
          const _StatusDot(
            isActive: true,
            title: 'Pix estornado',
            backgroundColor: Colors.orange,
          ),
        ] else if(isOverdue) ...[
          const _StatusDot(
            isActive: true,
            title: 'Pagamento Pix vencido',
            backgroundColor: Colors.red,
          ),
        ] else ...[
          _StatusDot(
            isActive: currentStatus >= 2,
            title: 'Pagamento',
          ),
          const _CustomDivider(),
          _StatusDot(
            isActive: currentStatus >= 3,
            title: 'Preparando o pedido',
          ),
          const _CustomDivider(),
          _StatusDot(
            isActive: currentStatus >= 4,
            title: 'Envio',
          ),
          const _CustomDivider(),
          _StatusDot(
            isActive: currentStatus >= 5,
            title: 'Pedido entregue',
          ),
        ],

      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 3.0,
      ),
      height: 10.0,
      width: 2.0,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {

  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusDot({
    super.key,
    required this.isActive,
    required this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwatchColor,
            ),
            color: isActive ? backgroundColor ?? CustomColors.customSwatchColor : Colors.transparent,
          ),
          child: isActive ?
            const Icon(
              Icons.check,
              size: 13,
              color: Colors.white,
            ) : const SizedBox.shrink(),
        ),

        const SizedBox(width: 5.0),

        // texto
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}