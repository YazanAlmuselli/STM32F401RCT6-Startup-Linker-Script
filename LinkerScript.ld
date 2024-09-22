/*
 @ File Name : LinkerScript
 @ Author    : Yazan Abd-Almajeed
 @ Brief     : LinkerScript File to Assign Absoulute Addresses for STM32F401xx
*/

_estack = ORIGIN(RAM) + LENGTH(RAM);

_Min_Heap_Size = 0x200 ;  /* Required amount of heap */
_Min_Stack_Size = 0x400 ; /* Required amount of stack */

MEMORY{
  RAM    (wrx) : ORIGIN = 0x20000000, LENGTH = 64K
  FLASH  (rx)  : ORIGIN = 0x08000000, LENGTH = 256K
}

SECTIONS{
  .isr_vector : 
  {
    . = ALIGN(4);
    *(.isr_vector)
    . = ALIGN(4);
  } >FLASH

  .text : 
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    . = ALIGN(4);
    _etext = .;
  } >FLASH

  .rodata : 
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } >FLASH

  _sidata = LOADADDR(.data);

  .data : 
  {
    _sdata = .;
    . = ALIGN(4);
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >RAM AT> FLASH
  
  .bss : 
  {
    _sbss = .;
    . = ALIGN(4);
    *(.bss)
    *(.bss*)
    . = ALIGN(4);
    _ebss = .;
  } >RAM

  ._user_heap_stack :
  {
    . = ALIGN(8);
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } >RAM
}